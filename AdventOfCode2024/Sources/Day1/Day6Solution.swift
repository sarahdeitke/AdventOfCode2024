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
    /// up, right, down, left
    let dirs = [[-1, 0], [0, 1], [1, 0], [0, -1]]
    

    func part1() {
        var lines = Helpers().readFile(fileName: "Day6Input")
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
    
    func part2() {
        var lines = Helpers().readFile(fileName: "Day6Input")
        var sum = 0
        
        do {
            let (startRow, startCol) = try findStartingLoc(lines: lines)
            print("Start row: ", startRow, "Start col: ", startCol)

            /// build the path and collect the unique locations
            let guardPath = buildGuardPath(linesCopy: lines, r: startRow, c: startCol)
            
            print("Guard path count: ", guardPath.count)
            
            for i in 0..<guardPath.count {
                if (i % 100 == 0) {
                    print("i: ", i)
                }
                let (blockR, blockC) = guardPath[i]
//                print("blockR: ", blockR, "blockC: ", blockC)
                let temp = lines[blockR][blockC]
                lines[blockR].replaceSubrange(blockC...blockC, with: "O")
                var row = startRow
                var col = startCol
                var dir = 0
                
                // start a timer
                let start = DispatchTime.now()
                
                while (row >= 0 && row < lines.count && col >= lines[row].startIndex && col < lines[row].endIndex) {
                    /// check if 3 seconds have passed
                    let end = DispatchTime.now()
                    let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
                    let timeInterval = Double(nanoTime) / 1_000_000_000
                    if (timeInterval > 0.1) {
                        print("Time limit exceeded, assume looping")
                        sum += 1
                        break
                    }
                    
                    if (lines[row][col] == "#" || lines[row][col] == "O") {
                        /// take a step back
                        col = lines[row].index(col, offsetBy: -dirs[dir][1])
                        row -= dirs[dir][0]
                        
                        /// turn right
                        dir = (dir + 1) % 4
                    }
                    
                    let colIdx = lines[row].distance(from: lines[row].startIndex, to: col)
                    if (colIdx + dirs[dir][1] >= lines[row].count || colIdx + dirs[dir][1] < 0) {
                        break
                    }
                    
                    col = lines[row].index(col, offsetBy: dirs[dir][1])
                    row += dirs[dir][0]
                }
                
                lines[blockR].replaceSubrange(blockC...blockC, with: String(temp))
            }
            
        } catch {
            print("Error: \(error)")
        }
        
        
        print(sum)
    }
    
    
    func buildGuardPath(linesCopy: [String], r: Int, c: String.Index) -> [(Int, String.Index)] {
        var guardPath = [(Int, String.Index)]()
        
        var lines = linesCopy
        var row = r
        var col = c
        var dir = 0
        
        while (row >= 0 && row < lines.count && col >= lines[row].startIndex && col < lines[row].endIndex) {
            if (lines[row][col] == "." || (lines[row][col] == "^" && guardPath.count != 0) || lines[row][col] == "X") {
                /// tracking uniqueness
                if (lines[row][col] != "X") {
                    guardPath.append((row, col))
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
        
        return guardPath
        
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
