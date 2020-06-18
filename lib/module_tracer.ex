defmodule NewRelicTools.ModuleTracer do
  @moduledoc """
  Module that helps define tracing for all functions in a module.
  Do not use the NewRelic.Tracer in the same module if you are using this!!

  if you want to trace only the public functions
  ```
  use NewRelicTools.ModuleTracer, trace_private?: false
  ```

  if you want to trace the private functions

  ```
  use NewRelicTools.ModuleTracer, trace_private?: true
  ```

  """

  defmacro __using__(trace_private?: trace_private) do
    if trace_private do
      quote do
        # Yes, this is the right order. The latest @on_definition happens first
        # No, I didn't knew this before
        use NewRelic.Tracer
        @on_definition {NewRelicTools.ModuleTracer, :all}
      end
    else
      quote do
        use NewRelic.Tracer
        @on_definition {NewRelicTools.ModuleTracer, :only_public}
      end
    end
  end

  @doc false
  def all(%{module: module}, _access, name, _args, _guards, _body) do
    # The lib only traces if this atribute is set, and it removes it after every
    # definition. If we want to trace every call we make, we just need to set it
    # before they do their __on_definition__
    Module.put_attribute(module, :trace, name)
  end

  @doc false
  def only_public(%{module: module}, :def, name, _args, _guards, _body) do
    Module.put_attribute(module, :trace, name)
  end

  def only_public(_env, _access, _name, _args, _guards, _body) do
    nil
  end
end
