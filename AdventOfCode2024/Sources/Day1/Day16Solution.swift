//
//  Day16Solution.swift
//  AdventOfCode2024
//
//  Created by Sarah Deitke on 12/17/24.
//
import Foundation

public class Day16Solution {
    func part1() {
        let map = Helpers().readFile(fileName: "Day16Input").map { Array($0) }
        
        let start = findS(map: map)
        print(start)
        /// pos, dir, cost, steps forward, turns
        var queue = [(start, [0, 1], 0)]
        
        var minCost = Int.max
        var visited = Set<[Int]>()
        
        while !queue.isEmpty {
            queue.sort { $0.2 < $1.2 }
            let (pos, currDir, currCost) = queue.removeFirst()
            
            for dir in getValidDirs(currentDir: currDir) {
                let newPos = [pos[0] + dir[0], pos[1] + dir[1]]
                
                if isValidPos(pos: newPos, map: map) {
                    let addedCost = dir == currDir ? 1 : 1001
                    let newCost = currCost + addedCost
                    
                    if map[newPos[0]][newPos[1]] == "E" {
                        print(newCost)
                        minCost = min(minCost, newCost)
                        continue
                    }
                    
                    if map[newPos[0]][newPos[1]] == "." && !visited.contains(newPos) {
                        queue.append((newPos, dir, newCost))
                        visited.insert(newPos)
                    }
                }
            }
        }
        
        print(minCost)
    }
    
    func isValidPos(pos: [Int], map: [[Character]]) -> Bool {
        return pos[0] >= 0 && pos[0] < map.count && pos[1] >= 0 && pos[1] < map[0].count
    }
    
    func getValidDirs(currentDir: [Int]) -> [[Int]] {
        if currentDir == [0, 1] {
            return [[0, 1], [1, 0], [-1, 0]]
        } else if currentDir == [0, -1] {
            return [[0, -1], [1, 0], [-1, 0]]
        } else if currentDir == [1, 0] {
            return [[0, 1], [0, -1], [1, 0]]
        } else {
            return [[0, 1], [0, -1], [-1, 0]]
        }
    }
    
    
    func findS(map: [[Character]]) -> [Int] {
        for i in 0..<map.count {
            for j in 0..<map[i].count {
                if map[i][j] == "S" {
                    return [i, j]
                }
            }
        }
        return [0,0]
    }
}
