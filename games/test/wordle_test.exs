defmodule Games.WordleTest do
  use ExUnit.Case
  doctest Games.Wordle

  test "feedback/2 equal all green" do
    assert Games.Wordle.feedback("aaaaa", "aaaaa") == [:green, :green, :green, :green, :green]
  end

  test "feedback/2 one not found" do
    assert Games.Wordle.feedback("aaaaa", "aaaab") == [:green, :green, :green, :green, :grey]
  end

  test "feedback/2 contains at diff positions" do
    assert Games.Wordle.feedback("abdce", "edcba") == [:yellow, :yellow, :yellow, :yellow, :yellow]
  end

  test "feedback/2 duplicate characters" do
    assert Games.Wordle.feedback("aaabb", "xaaaa") == [:grey, :green, :green, :yellow, :grey]
  end

  test "feedback/2 duplicate characters again" do
    assert Games.Wordle.feedback("XXXAA", "AAAAY") == [:yellow, :grey, :grey, :green, :grey]
  end
end
