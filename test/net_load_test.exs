defmodule NetLoadTest do
  use ExUnit.Case
  doctest NetLoad

  test "greets the world" do
    assert NetLoad.hello() == :world
  end
end
