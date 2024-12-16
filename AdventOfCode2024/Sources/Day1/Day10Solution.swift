//
//  Day10Solution.swift
//  AdventOfCode2024
//
//  Created by Sarah Deitke on 12/15/24.
//
import Foundation

public class Day10Solution {
//    This larger example has 9 trailheads. Considering the trailheads in reading order, they have scores of 5, 6, 5, 3, 1, 3, 5, 3, and 5.
//    Row 0, Col 2:  5
//    Row 0, Col 4:  6
//    Row 2, Col 4:  6
//    Row 4, Col 6:  3
//    Row 5, Col 2:  2
//    Row 5, Col 5:  4
//    Row 6, Col 0:  5
//    Row 6, Col 6:  3
//    Row 7, Col 1:  5
    
    func part1() {
        let map = Helpers().readFile(fileName: "Day10Input").map { Array($0) }
        
        var uniqueLocations = Set<String>()
        
        for row in 0..<map.count {
            for col in 0..<map[0].count {
                if (map[row][col] == "0") {
                    let validPaths = findFullTrails(map: map, r: row, c: col)
                    uniqueLocations.formUnion(validPaths)
                }
            }
        }
        
        print(uniqueLocations.count)
    }
    
    func findFullTrails(map: [[Character]], r: Int, c: Int) -> Set<String> {
        let dirs = [[-1, 0], [0, 1], [1, 0], [0, -1]]
        
        /// establish queue of locations to check
        var queue = [[r, c]]
        var height = 1
        
        var validLocations = Set<String>()
        
        while (height < 10 && !queue.isEmpty) {
            let count = queue.count
            
            for _ in 0..<count {
                let loc = queue.removeFirst()
                let row = loc[0]
                let col = loc[1]
                
                for dir in dirs {
                    let newRow = row + dir[0]
                    let newCol = col + dir[1]
                    
                    if (isValid(row: newRow, col: newCol, map: map)) {
                        if (height == 9 && map[newRow][newCol] == "9") {
                            let loc = "(\(r),\(c)), (\(newRow),\(newCol))"
                            validLocations.insert(loc)
                        }
                        else if (map[newRow][newCol] == Character(String(height))) {
                            queue.append([newRow, newCol])
                        }
                    }
                }
            }
            
            height += 1
        }
        
        return validLocations
    }
    
    func isValid(row: Int, col: Int, map: [[Character]]) -> Bool {
        return row >= 0 && row < map.count && col >= 0 && col < map[0].count
    }
}
