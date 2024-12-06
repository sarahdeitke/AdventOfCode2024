//
//  Day6Solution.swift
//  AdventOfCode2024
//
//  Created by Sarah Deitke on 12/6/24.
//
import Foundation

public class Day6Solution {
    enum Day6Error: Error {
        case startingLocationNotFound
    }

    func part1() {
        var lines = Helpers().readFile(fileName: "Day6Input")
        /// up, right, down, left
        let dirs = [[-1, 0], [0, 1], [1, 0], [0, -1]]
        var dir = 0
        
        var sum = 0
        
        do {
            var (row, col) = try findStartingLoc(lines: lines)

            /// start at the starting location
            while (row >= 0 && row < lines.count && col >= lines[row].startIndex && col < lines[row].endIndex) {
                if (lines[row][col] == "." || (lines[row][col] == "^" && sum != 0) || lines[row][col] == "X") {
                    /// tracking uniqueness
                    if (lines[row][col] != "X") {
                        sum += 1
                        lines[row].replaceSubrange(col...col, with: "X")
                    }
                }
                else if (lines[row][col] == "#") {
                    /// take a step back
                    col = lines[row].index(col, offsetBy: -dirs[dir][1])
                    row -= dirs[dir][0]
                    
                    /// turn right
                    dir = (dir + 1) % 4
                }
                
                col = lines[row].index(col, offsetBy: dirs[dir][1])
                row += dirs[dir][0]
            }
            
        } catch {
            print("Error: \(error)")
        }
        
        
        print(sum)
    }
    
    func findStartingLoc(lines: [String]) throws -> (Int, String.Index) {
        for i in 0..<lines.count {
            let line = lines[i]
            for j in 0..<line.count {
                let char = line[line.index(line.startIndex, offsetBy: j)]
                if char == "^" {
                    return (i, line.index(line.startIndex, offsetBy: j))
                }
            }
        }
        
        /// throw error
        throw Day6Error.startingLocationNotFound
    }
}
