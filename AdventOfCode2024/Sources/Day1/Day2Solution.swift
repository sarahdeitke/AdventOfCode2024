//
//  Day2Solution.swift
//  AdventOfCode2024
//
//  Created by Sarah Deitke on 12/2/24.
//
import Foundation

public class Day2Solution {
    func part1 () {
        /// read txt file
        let fileURL = Bundle.main.url(forResource: "Day2Input", withExtension: "txt")
        let content = try! String(contentsOf: fileURL!, encoding: .utf8)
        let lines = content.components(separatedBy: .newlines)
        var safeCount = 0
        
        for i in 0..<lines.count {
            /// split each line by space
            let line = lines[i].components(separatedBy: " ")
            if (computeIsSafe(line: line)) {
                safeCount += 1
            }
        }
        
        print(safeCount)
    }
    
    func computeIsSafe (line: [String]) -> Bool {
        let isAscending = Int(line[1])! - Int(line[0])! > 0
        
        for j in 1..<line.count {
            let diff = Int(line[j])! - Int(line[j-1])!
            /// check for direction of movement
            if (isAscending && diff < 0) {
                return false
            } else if (!isAscending && diff > 0) {
                return false
            }
            
            if (abs(diff) < 1 || abs(diff) > 3) {
                return false
            }
        }
        
        return true
    }
}
