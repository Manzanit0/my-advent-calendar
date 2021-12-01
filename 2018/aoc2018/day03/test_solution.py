import pytest
from collections import defaultdict
from solution import parse_claim
from solution import mark_claim_area
from solution import count_overlapping_inches


def test_parse_dataset():
    raw_claim = "#1 @ 755,138: 26x19"
    claim = parse_claim(raw_claim)
    assert claim == [755, 138, 26, 19]


def test_mark_cells():
    claim = [755, 138, 26, 19]
    fabric = defaultdict(int)
    mark_claim_area(fabric, claim)
    assert fabric[(755, 138)] == '/'
    assert fabric[(755, 138 + 18)] == '/'
    assert fabric[(755 + 25, 138)] == '/'


def test_double_marked_cells():
    claim = [755, 138, 26, 19]
    fabric = defaultdict(int)
    mark_claim_area(fabric, claim)
    mark_claim_area(fabric, claim)
    assert fabric[(755, 138)] == 'X'
    assert fabric[(755, 138 + 18)] == 'X'
    assert fabric[(755 + 25, 138)] == 'X'


def test_count_overlapping_cells():
    fabric = defaultdict(int)
    fabric[(1, 1)] = '/'
    fabric[(5, 2)] = 'X'
    fabric[(7, 4)] = '/'
    fabric[(2, 5)] = 'X'
    fabric[(9, 8)] = '/'
    fabric[(3, 9)] = 'X'
    count = count_overlapping_inches(fabric)
    assert count == 3
