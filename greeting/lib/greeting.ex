defmodule Greeting do
  def main(args) do
    # {opts, _word, _errors} = OptionParser.parse(args, switches: [time: :string])
    # IO.puts("Good #{opts[:time] || "morning"}!")

    {opts, _word, _errors} = OptionParser.parse(args, switches: [upcase: :string])
    IO.puts( opts[:upcase] || "Good morning!")
  end
end
