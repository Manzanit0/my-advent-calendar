from common.util import read_file


def calculate_checksum(box_ids):
    ids_with_2 = 0
    ids_with_3 = 0

    for id in box_ids:
        if has_repeated_letters(id, 2):
            ids_with_2 += 1

        if has_repeated_letters(id, 3):
            ids_with_3 += 1

    return ids_with_2*ids_with_3


def has_repeated_letters(code, amount):
    count = 0
    for character in code:
        count = code.count(character)
        if count == amount:
            return True

    return False

def find_similar_codes(box_ids):
    for code in box_ids:
        for code2 in box_ids:
            count_diffs = 0
            for a, b in zip(code, code2):
                if a!=b:
                    count_diffs += 1
            if count_diffs == 1: return [code, code2]


def solve_part1(path):
    box_ids = read_file(path)
    return calculate_checksum(box_ids)


def solve_part2(path):
    box_ids = read_file(path)
    return find_similar_codes(box_ids)
