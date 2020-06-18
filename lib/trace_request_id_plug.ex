defmodule NewRelicTools.TraceRequestIdPlug do
  @moduledoc """
  Adds the current request_id to the tracing.
  Should be plugged after the plug that ensures the request id is in the
  Logger metadata.
  """

  @behaviour Plug
  def init(opts), do: opts

  def call(conn, _) do
    request_id = Keyword.get(Logger.metadata(), :request_id)

    NewRelic.add_attributes(request_id: request_id)

    conn
  end
end
