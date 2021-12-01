import pytest
import checksum


def test_detects_2_repeated_letters():
    assert checksum.has_repeated_letters('abcda', 2)


def test_detects_3_repeated_letters():
    assert checksum.has_repeated_letters('abcdaba', 3)


def test_detects_no_repeated_letters():
    assert checksum.has_repeated_letters('qwerty', 2) == False


def test_finds_similar_codes():
    codes = ['abcd', 'abxx', 'xxcd', 'abcx']
    pair = checksum.find_similar_codes(codes)
    assert pair == ['abcd', 'abcx']


def test_doesnt_find_similar_codes():
    codes = ['abcd', 'abxx', 'xxcd', 'xbcx']
    pair = checksum.find_similar_codes(codes)
    assert pair == None