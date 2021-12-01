package main

import (
	"fmt"
	"os"
	"path/filepath"
	"strconv"
	"strings"
)

func main() {
	Day1Part1("./input_1.txt")
	Day1Part2("./input_2.txt")
}

// Day1Part1 basically scans the input (list of depth variations) for an
// increase between the previous depth and the current one, tracking the amount
// of increases.
func Day1Part1(inputPath string) {
	input := ReadInput(inputPath)
	rawDepths := strings.Split(input, "\n")

	depthIncreases := 0
	previousDepth := -1 // Assumption that no negative depths provided.

	for _, rawDepth := range rawDepths {
		// Ignore EOF when reading input
		if rawDepth == "" {
			continue
		}

		currentDepth := ToInt(rawDepth)

		if previousDepth == -1 {
			previousDepth = currentDepth
			continue
		}

		if previousDepth < currentDepth {
			depthIncreases++
		}

		previousDepth = currentDepth
	}

	fmt.Printf("Solution to Day 1 Part 1: %d\n", depthIncreases)
}

// Day1Part2 scans for increases but with a sliding window such as:
// 199  A
// 200  A B
// 208  A B C
// 210    B C D
// 200  E   C D
// 207  E F   D
// 240  E F G
// 269    F G H
// 260      G H
// 263        H
func Day1Part2(inputPath string) {
	input := ReadInput(inputPath)
	rawDepths := strings.Split(input, "\n")

	calculateSlidingWindowSums := func(rawDepths []string) []int {
		window := []int{}
		result := []int{}

		for _, r := range rawDepths {
			// Ignore EOF when reading input
			if r == "" {
				continue
			}

			depth := ToInt(r)

			// If the window isn't full, keep pushing elements.
			if len(window) < 3 {
				window = append(window, depth)
				continue
			}

			sum := window[0] + window[1] + window[2]
			result = append(result, sum)

			// Slide the window
			window = append(window, depth)[1:]
		}

		// Add the last window's sum.
		sum := window[0] + window[1] + window[2]
		result = append(result, sum)

		return result
	}

	depthIncreases := 0
	previousDepth := -1 // Assumption that no negative depths provided.

	for _, currentDepth := range calculateSlidingWindowSums(rawDepths) {
		if previousDepth == -1 {
			previousDepth = currentDepth
			continue
		}

		if previousDepth < currentDepth {
			depthIncreases++
		}

		previousDepth = currentDepth
	}

	fmt.Printf("Solution to Day 1 Part 2: %d\n", depthIncreases)
}

func ReadInput(filename string) string {
	absPath, err := filepath.Abs(filename)
	if err != nil {
		panic(fmt.Errorf("unable get absolut path for the input file: %s", err.Error()))
	}

	content, err := os.ReadFile(absPath)
	if err != nil {
		panic(fmt.Errorf("unable to read input file: %s", err.Error()))
	}

	return string(content)
}

func ToInt(s string) int {
	i, err := strconv.Atoi(s)
	if err != nil {
		panic(fmt.Errorf("unable to convert string to int: %s", err.Error()))
	}

	return i
}
