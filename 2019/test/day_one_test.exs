defmodule DayOneTest do
  use ExUnit.Case

  describe "part 1" do
    test "test simple calculation of fuel" do
      dataset = [{12, 2}, {14, 2}, {1969, 654}, {100_756, 33583}]

      for {mass, required_fuel} <- dataset do
        assert required_fuel == DayOne.calculate_fuel(mass)
      end
    end
  end

  describe "part 2" do
    test "recursive calculation of fuel" do
      dataset = [{14, 2}, {1969, 966}, {100_756, 50346}]

      for {mass, required_fuel} <- dataset do
        assert required_fuel == DayOne.calculate_fuel_recursively(mass)
      end
    end
  end
end
