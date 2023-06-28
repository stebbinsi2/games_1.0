defmodule Games.RockPaperScissors do
  @moduledoc """
  Documentation for `Games.RockPaperScissors`.
  """
  @valid_choices ["rock", "paper", "scissors"]

  @doc """
  Starts the game.
  """
  @spec play() :: binary
  def play() do
    Enum.random(@valid_choices)
    |> guess()
  end

  defp guess(opponent_choice) do
    player_choice = prompt()

    if player_choice in @valid_choices do
      case {player_choice, opponent_choice} do
        {"rock", "scissors"} -> "You Win! #{player_choice} beats #{opponent_choice}"
        {"paper", "rock"} -> "You Win! #{player_choice} beats #{opponent_choice}"
        {"scissors", "paper"} -> "You Win! #{player_choice} beats #{opponent_choice}"
        {"rock", "paper"} -> "You lose! #{opponent_choice} beats #{player_choice}"
        {"paper", "scissors"} -> "You lose! #{opponent_choice} beats #{player_choice}"
        {"scissors", "rock"} -> "You lose! #{opponent_choice} beats #{player_choice}"
        {_, _} -> "It's a tie!"
      end
    else
      IO.puts("Invalid player input.")
      guess(opponent_choice)
    end
  end

  defp prompt() do
    IO.gets("(rock/paper/scissors): ")
    |> to_string()
    |> String.trim_trailing()
  end
end
