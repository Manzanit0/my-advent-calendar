#!/usr/bin/env -S deno run --allow-read

// Problem description:
// https://adventofcode.com/2020/day/2

import { parse } from "https://deno.land/std/flags/mod.ts";

function readInput(): string[] {
    const args = parse(Deno.args)
    return Deno.readTextFileSync(args.file)
        .split("\n")
        .filter(x => x !== '')
}

type PasswordPolicy = {minimum: number, maximum: number, letter: string}
type Password = {policy: PasswordPolicy, password: string}

function parsePassword(input: string): Password {
    const [policy, password] = input.split(':')
    const [range, letter] = policy.split(' ')
    const [minimum, maximum] = range.split('-')

    return {
        policy: {minimum: parseInt(minimum), maximum: parseInt(maximum), letter: letter.trim()},
        password: password.trim()
    }
}

function countValidPasswords(passwords: Password[], validator: (x: Password) => boolean): number {
    return passwords.filter(x => validator(x)).length
}

function isValidPassword(password: Password): boolean {
    const char = password.password.split('').filter(x => x == password.policy.letter);
    return char.length >= password.policy.minimum && char.length <= password.policy.maximum
}

// OTCP: Official Toboggan Corporate Policy
function isOTCPValidPassword(password: Password): boolean {
    const firstPositionContains = password.password[password.policy.minimum-1] === password.policy.letter
    const secondPositionContains = password.password[password.policy.maximum-1] === password.policy.letter
    return  firstPositionContains ? !secondPositionContains : secondPositionContains
}

const passwords = readInput().map(x => parsePassword(x))
const count = countValidPasswords(passwords, isOTCPValidPassword)
console.log(count)
