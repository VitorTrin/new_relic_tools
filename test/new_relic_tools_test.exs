defmodule NewRelicToolsTest do
  use ExUnit.Case
  doctest NewRelicTools

  test "greets the world" do
    assert NewRelicTools.hello() == :world
  end
end
