defmodule GitExploringTest do
  use ExUnit.Case
  doctest GitExploring

  test "greets the world" do
    assert GitExploring.hello() == :world
  end
end
