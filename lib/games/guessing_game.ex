defmodule Games.GuessingGame do
  @moduledoc """
  Documentation for `Games.GuessingGame`.
  """

  @doc """
  Starts the game.
  """
  def play() do
    correct_num = :rand.uniform(10)
    guess(correct_num)
  end

  defp guess(correct_num) do
    guess_num = prompt()

    if guess_num === correct_num do
      IO.puts("Correct!")
    else
      if guess_num > correct_num, do: IO.puts("Too High!"), else: IO.puts("Too Low!")
      guess(correct_num)
    end
  end

  defp prompt() do
    IO.gets("Enter your guess: ")
    |> to_string()
    |> String.trim_trailing()
    |> String.to_integer()
  end
end
