#! /usr/bin/env elixir

# Problem: https://adventofcode.com/2021/day/3

parse_input = fn content ->
  content
  |> String.split("\n")
  |> Enum.filter(fn x -> x != "" end)
end

transpose_matrix = fn matrix ->
  matrix
  |> List.zip()
  |> Enum.map(&Tuple.to_list/1)
end

to_bit_list = fn binary ->
  binary |> String.split("") |> Enum.filter(fn x -> x != "" end)
end

transpose_binaries_list = fn binaries ->
  binaries
  |> Enum.map(to_bit_list)
  |> then(transpose_matrix)
end

get_relevant_bit = fn
  %{"0" => x, "1" => y}, :least when x < y -> "0"
  %{"0" => x, "1" => y}, :most when x < y -> "1"
  %{"0" => x, "1" => y}, :least when x > y -> "1"
  %{"0" => x, "1" => y}, :most when x > y -> "0"
end

most_common_bit = fn bit_list ->
  bit_list
  |> Enum.frequencies()
  |> then(&get_relevant_bit.(&1, :most))
end

least_common_bit = fn bit_list ->
  bit_list
  |> Enum.frequencies()
  |> then(&get_relevant_bit.(&1, :least))
end

bit_list_to_decimal = fn binary ->
  binary
  |> Enum.join("")
  |> String.trim()
  |> Integer.parse(2)
  |> Kernel.elem(0)
end

calculate_gamma_rate = fn binaries_list ->
  binaries_list
  |> then(transpose_binaries_list)
  |> Enum.map(most_common_bit)
  |> then(bit_list_to_decimal)
  |> IO.inspect(label: "Gamma rate")
end

calculate_epsilon_rate = fn binaries_list ->
  binaries_list
  |> then(transpose_binaries_list)
  |> Enum.map(least_common_bit)
  |> then(bit_list_to_decimal)
  |> IO.inspect(label: "Epsilon rate")
end

power_consumption = fn gamma_rate, epsilon_rate ->
  gamma_rate * epsilon_rate
end

## Part 1
binaries_list = File.read!("day_3.txt") |> then(parse_input)
gamma_rate = calculate_gamma_rate.(binaries_list)
epsilon_rate = calculate_epsilon_rate.(binaries_list)

IO.puts("Solution: #{power_consumption.(gamma_rate, epsilon_rate)}")
