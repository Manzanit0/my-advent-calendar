import pytest
import calibrator


def test_convert():
    values = ['-1', '0', '1', '546']
    converted_values = calibrator.convert_to_i(values)
    assert all(isinstance(value, int)for value in converted_values)


def test_sum():
    values = [10, 0, -101, 200]
    sum = calibrator.sum(values)
    assert sum == 109


def test_find_repeated():
    values = [1, 2, 3, 4, -2, -2, 5, 6, -8, 2]
    found = calibrator.find_repeated_frequencies(values)
    assert found == 6
