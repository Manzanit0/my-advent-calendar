#! /usr/bin/env elixir

# Much iteration going on... but can't be bothered to fit it into the same reduce.

count_increasing = fn list ->
  Enum.reduce(list, {nil, 0}, fn
    x, {nil, 0} ->
      {x, 0}

    x, {prev, sum} when x > prev ->
      {x, sum + 1}

    x, {_prev, sum} ->
      {x, sum}
  end)
end

parse_input = fn content ->
  content
  |> String.split("\n")
  |> Enum.filter(fn x -> x != "" end)
  |> Enum.map(&String.to_integer/1)
end

### PART 1
IO.write("Day 1 part 1: ")

File.read!("day_1.txt")
|> then(parse_input)
|> then(count_increasing)
|> Kernel.elem(1)
|> IO.inspect()

### PART 2
calculate_windows = fn [f, s, t | list] ->
  initial_window = [f, s, t]

  # We map the window sum, but accumulate the actual elements to slide in the
  # following interation.
  {window_sums, _} =
    Enum.map_reduce(list, initial_window, fn x, [_, s, t] -> {s + t + x, [s, t, x]} end)

  initial_window_sum = Enum.sum(initial_window)
  [initial_window_sum | window_sums]
end

IO.write("Day 1 part 2: ")

File.read!("day_1.txt")
|> then(parse_input)
|> then(calculate_windows)
|> then(count_increasing)
|> Kernel.elem(1)
|> IO.inspect()
