defmodule Expyplot do
  use Application
  require Logger
  @moduledoc """
  This is the supervisor that runs the application.
  For now, this module doesn't really do anything else.
  """

  def start(_type, _args) do
    Logger.info("This is using the agro branch of Expyplot...")
    Server.Pysupervisor.start_link
    connect_to_python()
  end

  defp connect_to_python do
    result = Server.Commapi.start_link
    case result do
      {:ok, pid} -> {:ok, pid}
      {:error, {:shutdown, {:failed_to_start_child, Server.Pycomm, {:bad_return_value, {:error, :econnrefused}}}}} -> connect_to_python()
    end
  end
end
