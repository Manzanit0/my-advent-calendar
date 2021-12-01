defmodule DayOne do
  def solution() do
    part_1 =
      "./priv/day_one_1.txt"
      |> stream_file_lines()
      |> Stream.map(&calculate_fuel/1)
      |> aggregate_fuel_results()

    part_2 =
      "./priv/day_one_2.txt"
      |> stream_file_lines()
      |> Stream.map(&calculate_fuel_recursively/1)
      |> aggregate_fuel_results()

    %{solution_1: part_1, solution_2: part_2}
  end

  def calculate_fuel(mass) do
    mass
    |> Kernel./(3)
    |> Float.floor()
    |> Kernel.-(2)
    |> positivise()
  end

  def calculate_fuel_recursively(mass, acc \\ 0)

  def calculate_fuel_recursively(mass, acc) when mass <= 0, do: acc

  def calculate_fuel_recursively(mass, accumuluated_fuel) do
    fuel_required = calculate_fuel(mass)
    calculate_fuel_recursively(fuel_required, accumuluated_fuel + fuel_required)
  end

  defp aggregate_fuel_results(fuels), do: Enum.reduce(fuels, 0, &Kernel.+/2)

  defp positivise(num) when num < 0, do: 0
  defp positivise(num), do: num

  defp stream_file_lines(file_name) do
    file_name
    |> Path.expand()
    |> File.stream!()
    |> Stream.map(&sanitise/1)
  end

  defp sanitise(row) do
    row
    |> String.replace("\n", "")
    |> String.to_integer()
  end
end
