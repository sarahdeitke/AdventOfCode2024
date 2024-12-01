//
//  Day1Solution.swift
//  AdventOfCode2024
//
//  Created by Sarah Deitke on 12/1/24.
//
import Foundation


/// Day 1 Solution class - Historian Hysteria
class Day1Solution {
    func part1 () {
        /// read txt file
        let fileURL = Bundle.main.url(forResource: "Day1Input", withExtension: "txt")
        let content = try! String(contentsOf: fileURL!, encoding: .utf8)
        let lines = content.components(separatedBy: .newlines)
        print(lines[0])

    }
}
