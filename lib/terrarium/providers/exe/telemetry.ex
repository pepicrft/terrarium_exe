defmodule Terrarium.Providers.Exe.Telemetry do
  @moduledoc """
  Telemetry events emitted by the exe.dev provider.

  ## Events

  ### `[:terrarium, :exe, :api_request, :start | :stop | :exception]`

  Emitted for each HTTPS API call to exe.dev.

  - Start metadata: `%{method: :post, url: String.t()}`
  - Stop metadata: `%{method: :post, url: String.t(), status: integer()}`
  - Exception metadata: `%{method: :post, url: String.t(), error: term()}`
  """

  @doc false
  def span(event, metadata, fun) do
    :telemetry.span([:terrarium, :exe, event], metadata, fn ->
      result = fun.()
      {result, %{result: result}}
    end)
  end
end
