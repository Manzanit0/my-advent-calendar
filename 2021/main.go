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
}

func Day1Part1(inputPath string) {
	input := ReadInput(inputPath)
	rawDepths := strings.Split(input, "\n")

	depthIncreases := 0
	previousDepth := -1 // Assumption that no negative depths provided.

	for _, rawDepth := range rawDepths {
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
