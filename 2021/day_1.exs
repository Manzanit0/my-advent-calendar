#! /usr/bin/env elixir

# Much iteration going on... but can't be bothered to fit it into the same reduce.
File.read!("./input_1.txt")
|> String.split("\n")
|> Enum.filter(fn x -> x != "" end)
|> Enum.map(&String.to_integer/1)
|> Enum.reduce({nil, 0}, fn
  x, {nil, 0} ->
    {x, 0}

  x, {prev, sum} when x > prev ->
    {x, sum + 1}

  x, {_prev, sum} ->
    {x, sum}
end)
|> Kernel.elem(1)
|> IO.inspect()
