//
//  Day6Solution.swift
//  AdventOfCode2024
//
//  Created by Sarah Deitke on 12/6/24.
//
import Foundation

public class Day6Solution {
    /// up, right, down, left
    let dirs = [[-1, 0], [0, 1], [1, 0], [0, -1]]
    

    func part1() {
        var map = Helpers().readFile(fileName: "Day6Input").map { Array($0) }
        var dir = 0
        var sum = 0
        
        var (row, col) = findStartingLoc(map: map)

        /// start at the starting location
        while (isValid(row: row, col: col, map: map)) {
            if (map[row][col] == "." || (map[row][col] == "^" && sum != 0) || map[row][col] == "X") {
                /// tracking uniqueness
                if (map[row][col] != "X") {
                    sum += 1
                    map[row][col] = "X"
                }
            }
            else if (map[row][col] == "#") {
                /// take a step back
                col -= dirs[dir][1]
                row -= dirs[dir][0]
                
                /// turn right
                dir = (dir + 1) % 4
            }
            
            col += dirs[dir][1]
            row += dirs[dir][0]
        }
        
        print(sum)
    }
    
    func part2() {
        var map = Helpers().readFile(fileName: "Day6Input").map { Array($0) }
        var sum = 0
        
        let (startRow, startCol) = findStartingLoc(map: map)
        print("Start row: ", startRow, "Start col: ", startCol)

        /// build the path and collect the unique locations
        let guardPath = buildGuardPath(mapCopy: map, r: startRow, c: startCol)
        
        print("Guard path count: ", guardPath.count)
        
        for i in 0..<guardPath.count {
            if (i % 100 == 0) {
                print("i: ", i)
            }
            let (blockR, blockC) = guardPath[i]
//                print("blockR: ", blockR, "blockC: ", blockC)
            let temp = map[blockR][blockC]
            map[blockR][blockC] = "O"
            var row = startRow
            var col = startCol
            var dir = 0
            
            // start a timer
            let start = DispatchTime.now()
            
            while (isValid(row: row, col: col, map: map)) {
                /// check if 3 seconds have passed
                let end = DispatchTime.now()
                let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
                let timeInterval = Double(nanoTime) / 1_000_000_000
                if (timeInterval > 0.1) {
                    print("Time limit exceeded, assume looping")
                    sum += 1
                    break
                }
                
                if (map[row][col] == "#" || map[row][col] == "O") {
                    /// take a step back
                    col -= dirs[dir][1]
                    row -= dirs[dir][0]
                    
                    /// turn right
                    dir = (dir + 1) % 4
                }
                
                col += dirs[dir][1]
                row += dirs[dir][0]
            }
            
            map[blockR][blockC] = temp
        }
            
        
        
        print(sum)
    }
    
    
    func buildGuardPath(mapCopy: [[Character]], r: Int, c: Int) -> [(Int, Int)] {
        var guardPath = [(Int, Int)]()
        
        var map = mapCopy
        var row = r
        var col = c
        var dir = 0
        
        while (isValid(row: row, col: col, map: map)) {
            if (map[row][col] == "." || (map[row][col] == "^" && guardPath.count != 0) || map[row][col] == "X") {
                /// tracking uniqueness
                if (map[row][col] != "X") {
                    guardPath.append((row, col))
                    map[row][col] = "X"
                }
            }
            else if (map[row][col] == "#") {
                /// take a step back
                col -= dirs[dir][1]
                row -= dirs[dir][0]
                
                /// turn right
                dir = (dir + 1) % 4
            }
            
            col += dirs[dir][1]
            row += dirs[dir][0]
        }
        
        return guardPath
        
    }
    
    func findStartingLoc(map: [[Character]]) -> (Int, Int) {
        for i in 0..<map.count {
            for j in 0..<map[i].count {
                if map[i][j] == "^" {
                    return (i, j)
                }
            }
        }
        
        /// throw error
        fatalError("Starting location not found")
    }
    
    private func isValid(row: Int, col: Int, map: [[Character]]) -> Bool {
        return row >= 0 && row < map.count && col >= 0 && col < map[row].count
    }
}
