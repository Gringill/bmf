defmodule Mix.Tasks.PrepareAws do
  use Mix.Task

  @shortdoc "Ensure a cluster, task definition, and service are created and running on AWS."

  @typep step :: :create_cluster | :create_task_definition | :create_service
  @typep opts :: keyword()
  @typep cmd_result :: {Collectible.t(), exit_status :: non_neg_integer()}
  @typep tagged_response :: :ok | {:error, {step, cmd_result}}

  @spec run([binary()]) :: tagged_response
  def run(args) do
    {opts, []} = OptionParser.parse!(args, strict: [cluster_name: :string])

    with :ok <- create_cluster(opts),
         :ok <- create_task_definition(opts),
         :ok <- create_service(opts) do
      Mix.Shell.IO.info("Success!")
    else
      {:error, {step, {error, exit_status}}} ->
        Mix.Shell.IO.error("""
        #{step}, exit_status: #{exit_status}
        --

        error: #{error}
        """)

      error ->
        Mix.Shell.IO.error("#{inspect(error)}")
    end
  end

  @spec create_cluster(opts) :: tagged_response
  defp create_cluster(opts) do
    with {:ok, cn} <- take_opt(opts, :cluster_name) do
      aws(:create_cluster, ["ecs", "create-cluster", "--cluster-name", "#{cn}"])
    end
  end

  @spec create_task_definition(opts) :: tagged_response
  defp create_task_definition(_) do
    container_definitions = [
      %{
        name: "fargate-app",
        image: "httpd:2.4",
        portMappings: [%{containerPort: 80, hostPort: 80, protocol: "tcp"}],
        essential: true,
        entryPoint: ["sh", "-c"],
        command: [
          "/bin/sh -c \"echo '<html> <head> <title>Amazon ECS Sample App</title> <style>body {margin-top: 40px; background-color: #333;} </style> </head><body> <div style=color:white;text-align:center> <h1>Amazon ECS Sample App</h1> <h2>Congratulations!</h2> <p>Your application is now running on a container in Amazon ECS.</p> </div></body></html>' >  /usr/local/apache2/htdocs/index.html && httpd-foreground\""
        ]
      }
    ]

    args = [
      "ecs",
      "register-task-definition",
      "--family=sample-fargate",
      "--network-mode=awsvpc",
      "--container-definitions=#{Poison.encode!(container_definitions)}",
      "--requires-compatibilities=FARGATE",
      "--cpu=256",
      "--memory=512"
    ]

    aws(:create_task_definition, args)
  end

  @spec create_service(opts) :: tagged_response
  defp create_service(opts) do
    with {:ok, cn} <- take_opt(opts, :cluster_name) do
      args = [
        "ecs",
        "create-service",
        "--cluster=#{cn}",
        "--service-name=fargate-service",
        "--task-definition=sample-fargate:1",
        "--desired-count=2",
        "--launch-type=FARGATE",
        "--network-configuration=awsvpcConfiguration={subnets=[subnet-4d916b3a],securityGroups=[sg-71691514]}"
      ]

      aws(:create_service, args)
    end
  end

  defp take_opt(args, key) do
    case Keyword.has_key?(args, key) do
      true ->
        {:ok, args[key]}

      false ->
        error = "missing arg: #{key}"
        Mix.Shell.IO.error(error)
        {:error, error}
    end
  end

  defp aws(step, args) do
    case System.cmd("aws", args, stderr_to_stdout: true) do
      {ret, 0} ->
        IO.inspect(ret, label: step)
        :ok

      error ->
        {:error, {step, error}}
    end
  end
end
