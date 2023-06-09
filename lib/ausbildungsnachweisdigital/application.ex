defmodule Ausbildungsnachweisdigital.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AusbildungsnachweisdigitalWeb.Telemetry,
      # Start the Ecto repository
      Ausbildungsnachweisdigital.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Ausbildungsnachweisdigital.PubSub},
      # Start Finch
      {Finch, name: Ausbildungsnachweisdigital.Finch},
      # Start the Endpoint (http/https)
      AusbildungsnachweisdigitalWeb.Endpoint
      # Start a worker by calling: Ausbildungsnachweisdigital.Worker.start_link(arg)
      # {Ausbildungsnachweisdigital.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ausbildungsnachweisdigital.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AusbildungsnachweisdigitalWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
