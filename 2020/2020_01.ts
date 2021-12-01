#!/usr/bin/env -S deno run --allow-read

// Problem description:
// https://adventofcode.com/2020/day/1

// Comments:
// This is actually known as the knapsack problem. This solution
// is definitely not the most elegant or performant, but it's
// definitely the simplest. See more here:
// https://en.wikipedia.org/wiki/Knapsack_problem

function readInput(file: string): number[] {
    return Deno.readTextFileSync(file)
        .split("\n")
        .map(x => parseInt(x))
}

function calculatePart1(input: number[]) {
    for (const v of input) {
        for (const vv of input) {
            if ((v + vv) == 2020) {
                return v * vv
            }
        }
    }
}

function calculatePart2(input: number[]) {
    for (const v of input) {
        for (const vv of input) {
            for (const vvv of input) {
                if ((v + vv +vvv) == 2020) {
                    return v * vv * vvv
                }
            }
        }
    }
}

const input = readInput("./input.txt")
const result1 = calculatePart1(input)
const result2 = calculatePart2(input)
console.log('The answer to part 1 is', result1)
console.log('The answer to part 2 is', result2)
