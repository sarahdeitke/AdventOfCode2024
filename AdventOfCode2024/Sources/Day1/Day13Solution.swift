//
//  Day13Solution.swift
//  AdventOfCode2024
//
//  Created by Sarah Deitke on 12/15/24.
//
import Foundation

public class Day13Solution {
    let A = 3
    let B = 1
    var A_X = 0
    var A_Y = 0
    var B_X = 0
    var B_Y = 0
    var memo = [String: Int]()
    
    func part1() {
        let lines = Helpers().readFile(fileName: "Day13Input")
        
        var sum = 0
        for i in 0..<(lines.count+1)/4 {
            let buttonA = lines[i*4]
            /// drop comma from end of string
            A_X = Int(buttonA.components(separatedBy: " ")[2].components(separatedBy: "+")[1].dropLast())!
            A_Y = Int(buttonA.components(separatedBy: " ")[3].components(separatedBy: "+")[1])!
            let buttonB = lines[i*4+1]
            B_X = Int(buttonB.components(separatedBy: " ")[2].components(separatedBy: "+")[1].dropLast())!
            B_Y = Int(buttonB.components(separatedBy: " ")[3].components(separatedBy: "+")[1])!
            let prize = lines[i*4+2]
            let X = Int(prize.components(separatedBy: " ")[1].components(separatedBy: "=")[1].dropLast())!
            let Y = Int(prize.components(separatedBy: " ")[2].components(separatedBy: "=")[1])!
            
            let result = computeMinCost(X: X, Y: Y, accCost: 0, itrA: 0, itrB: 0)
            if (result < Int.max) {
                sum += result
            }
        }

        print(sum)
    }
    
    
    func computeMinCost(X: Int, Y: Int, accCost: Int, itrA: Int, itrB: Int) -> Int {
        if (X == 0 && Y == 0) {
            return accCost
        }
        
        if (X < 0 || Y < 0 || itrA > 100 || itrB > 100) {
            return Int.max
        }
        
        let key = "\(X)-\(Y)-\(itrA)-\(itrB)"
        if let cachedResult = memo[key] {
            return cachedResult
        }
        
        let result = min(computeMinCost(X: X-A_X, Y: Y-A_Y, accCost: accCost+A, itrA: itrA+1, itrB: itrB),
                   computeMinCost(X: X-B_X, Y: Y-B_Y, accCost: accCost+B, itrA: itrA, itrB: itrB+1))
            
        memo[key] = result
        return result
    }
}
