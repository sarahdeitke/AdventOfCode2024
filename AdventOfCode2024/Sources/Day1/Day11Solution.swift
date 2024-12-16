//
//  Day11Solution.swift
//  AdventOfCode2024
//
//  Created by Sarah Deitke on 12/15/24.
//
import Foundation

public class Day11Solution {
    var memo = [String: Int]()
    
    func part2() {
        let line = Helpers().readFile(fileName: "Day11Input")[0]
        let stones = line.components(separatedBy: " ").map { Int($0)! }
        
        var count = 0
        for stone in stones {
            count += executeRules(stone: stone, itr: 75)
        }
        
        print(count)
    }
    
    func part1() {
        let line = Helpers().readFile(fileName: "Day11Input")[0]
        var stones = line.components(separatedBy: " ").map { Int($0)! }
        
        for _ in 0..<25 {
            stones = executeRules(stones: stones)
        }
        
        print(stones.count)
    }
    
    func executeRules(stone: Int, itr: Int) -> Int {
        if (itr == 0) {
            return 1
        }
        
        let key = "\(stone)-\(itr)"
        if let cachedResult = memo[key] {
            return cachedResult
        }

        var res = 0
        if (stone == 0) {
            res = executeRules(stone: 1, itr: itr-1)
        } else {
            let numDigits = String(stone).count
            if (numDigits % 2 == 0) {
                let stoneStr = String(stone)
                let firstHalf = stoneStr.prefix(numDigits/2)
                let secondHalf = stoneStr.suffix(numDigits/2)
                res = executeRules(stone: Int(firstHalf)!, itr: itr-1) + executeRules(stone: Int(secondHalf)!, itr: itr-1)
            }
            else {
                res = executeRules(stone: stone*2024, itr: itr-1)
            }
        }
        
        memo[key] = res
        
        return res
    }
    
    func executeRules(stones: [Int]) -> [Int] {
        var newStones = [Int]()
        for i in 0..<stones.count {
            let numDigits = String(stones[i]).count
            if (stones[i] == 0) {
                newStones.append(1)
            }
            else if (numDigits % 2 == 0) {
                let stoneStr = String(stones[i])
                let firstHalf = stoneStr.prefix(numDigits/2)
                let secondHalf = stoneStr.suffix(numDigits/2)
                newStones.append(Int(firstHalf)!)
                newStones.append(Int(secondHalf)!)
            }
            else {
                newStones.append(stones[i]*2024)
            }
        }
        
        return newStones
    }
}
