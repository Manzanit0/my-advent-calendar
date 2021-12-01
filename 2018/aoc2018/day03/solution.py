from common.util import read_file
from collections import defaultdict


def parse_claim(raw_claim):
    """ Potentially faster than a regex? """
    set1 = raw_claim.split(' ')
    separation = set1[2][:-1].split(',')
    area = set1[3].split('x')
    values = [separation[0], separation[1], area[0], area[1]]
    return list(map(int, values))


def mark_claim_area(fabric, claim):
    left, top, width, height = claim
    for i in range(left, left + width):
        for j in range(top, top + height):
            if fabric[(i, j)] == 0:
                fabric[(i, j)] = '/'
            elif fabric[(i, j)] == '/':
                fabric[(i, j)] = 'X'


def count_overlapping_inches(marked_fabric):
    return len([k for k, v in marked_fabric.items() if v == 'X'])


def solve_part1(path):
    raw_claims = read_file(path)
    fabric = defaultdict(int)
    for raw_claim in raw_claims:
        claim = parse_claim(raw_claim)
        mark_claim_area(fabric, claim)
    return count_overlapping_inches(fabric)
