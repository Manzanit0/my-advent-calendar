#! /usr/bin/env elixir

parse_input = fn content ->
  content
  |> String.split("\n")
  |> Enum.filter(fn x -> x != "" end)
end

### DAY 2 PART 1
multiply_course = fn %{horizontal: n, depth: m} -> n * m end

IO.write("Day 2 part 1: ")

File.read!("day_2.txt")
|> then(parse_input)
|> Enum.reduce(%{depth: 0, horizontal: 0}, fn
  "forward " <> n, acc ->
    i = String.to_integer(n)
    %{acc | horizontal: acc.horizontal + i}

  "down " <> n, acc ->
    i = String.to_integer(n)
    %{acc | depth: acc.depth + i}

  "up " <> n, acc ->
    i = String.to_integer(n)
    %{acc | depth: acc.depth - i}

  other, _acc ->
    raise "Got funny instruction: #{other}"
end)
|> then(multiply_course)
|> IO.inspect()

### DAY 2 PART 2
IO.write("Day 2 part 2: ")

File.read!("day_2.txt")
|> then(parse_input)
|> Enum.reduce(%{depth: 0, horizontal: 0, aim: 0}, fn
  "forward " <> n, acc ->
    i = String.to_integer(n)
    %{acc | horizontal: acc.horizontal + i, depth: acc.depth + acc.aim * i}

  "down " <> n, acc ->
    i = String.to_integer(n)
    %{acc | aim: acc.aim + i}

  "up " <> n, acc ->
    i = String.to_integer(n)
    %{acc | aim: acc.aim - i}

  other, _acc ->
    raise "Got funny instruction: #{other}"
end)
|> then(multiply_course)
|> IO.inspect()
