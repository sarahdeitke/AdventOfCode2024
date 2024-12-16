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
    let A_X = 17
    let A_Y = 86
    let B_X = 84
    let B_Y = 37
    var memo = [String: Int]()
    
    func part1() {
        print(computeMinCost(X: 7870, Y: 6450, accCost: 0, itrA: 0, itrB: 0))
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

//Button A: X+94, Y+34
//Button B: X+22, Y+67
//Prize: X=8400, Y=5400
