import os
import functools
from common.util import read_file


def convert_to_i(values):
    return list(map(int, values))


def sum(values):
    return functools.reduce(lambda x, y: x + y, values)


def find_repeated_frequencies(increments):
    frequency = 0
    found_frequencies = {0}

    while True:
        for increment in increments:
            frequency += increment

            if frequency in found_frequencies:
                return frequency

            found_frequencies.add(frequency)


def solve_part1(path):
    values_s = read_file(path)
    values_i = convert_to_i(values_s)
    return sum(values_i)


def solve_part2(path):
    values_s = read_file(path)
    values_i = convert_to_i(values_s)
    return find_repeated_frequencies(values_i)
