defmodule Games.Wordle do
  defp merge([], []) do
    []
  end

  defp merge([head1 | tail1], [head2 | tail2]) do
    [{head1, head2} | merge(tail1, tail2)]
  end

  defp include_occurrences(merge_result) do
    merge_result
    |> Enum.reduce([], fn {a_ch, g_ch}, acc ->
      a_chars = Enum.map(acc, fn {a_ch, _, _} -> a_ch end)
      freqs = Enum.frequencies(a_chars)
      a_occ_count = (freqs[a_ch] || 0) + 1
      [{a_ch, g_ch, a_occ_count} | acc]
    end)
    |> Enum.reverse()
  end

  defp condition_resolution(pairs_with_occs, answer_chars) do
    pairs_with_occs
    |> Enum.map(fn {a_ch, g_ch, a_occ_count} ->
      cond do
        a_ch === g_ch -> :green
        Enum.member?(answer_chars, g_ch) and a_occ_count === 1 -> :yellow
        true -> :grey
      end
    end)
  end

  # a = ["a", "a", "a", "b", "b"]
  # g = ["x", "a", "a", "a", "a"]

  # [{"a", "x"}, {"a", "a"}, {"a", "a"}, {"b", "a"}, {"b", "a"}]

  # [{"a", "x", 1}, {"a", "a", 2}, {"a", "a", 3}, {"b", "a", 1}, {"b", "a", 2}]

  # [:grey,         :green,        :green,        :yellow,       :grey]

  def feedback(answer, guess) do
    cond do
      answer === guess ->
        [:green, :green, :green, :green, :green]

      true ->
        answer_chars = String.split(answer, "", trim: true)
        guess_chars = String.split(guess, "", trim: true)

        merge(answer_chars, guess_chars)
        |> include_occurrences()
        |> condition_resolution(answer_chars)
    end
  end

  defp prompt() do
    guess =
      IO.gets("Enter a five letter word: ")
      |> to_string()
      |> String.trim_trailing()

    cond do
      String.length(guess) != 5 -> prompt()
      true -> guess
    end
  end

  def play() do
    answers = ["toast", "tarts", "hello", "beats"]
    guess_count = 3

    attempt(Enum.random(answers), guess_count)
  end

  def attempt(answer, attempt_count) do
    guess = prompt()

    reply = feedback(answer, guess)

    Enum.join(
      [
        "[",
        Enum.map_join(reply, ", ", fn elem ->
          ":#{Atom.to_string(elem)}"
        end),
        "]"
      ],
      ""
    )
    |> IO.puts()

    cond do
      reply === [:green, :green, :green, :green, :green] ->
        IO.puts("Correct guess.")

      attempt_count === 0 ->
        IO.puts("Too many attempts. Game over.")

      true ->
        IO.puts("Guess again.")
        attempt(answer, attempt_count - 1)
    end
  end
end
