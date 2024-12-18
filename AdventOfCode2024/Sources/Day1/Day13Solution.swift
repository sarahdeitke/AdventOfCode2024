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
    var a = 0
    var b = 0
    var c = 0
    var d = 0
    var memo = [String: Int64]()
    
    func part2() {
        let lines = Helpers().readFile(fileName: "Day13Input")
        
        var sum = 0
        for i in 0..<(lines.count+1)/4 {
            let buttonA = lines[i*4]
            /// drop comma from end of string
            a = Int(buttonA.components(separatedBy: " ")[2].components(separatedBy: "+")[1].dropLast())!
            c = Int(buttonA.components(separatedBy: " ")[3].components(separatedBy: "+")[1])!
            let buttonB = lines[i*4+1]
            b = Int(buttonB.components(separatedBy: " ")[2].components(separatedBy: "+")[1].dropLast())!
            d = Int(buttonB.components(separatedBy: " ")[3].components(separatedBy: "+")[1])!
            let prize = lines[i*4+2]
            let X = Int(prize.components(separatedBy: " ")[1].components(separatedBy: "=")[1].dropLast())!
            let Y = Int(prize.components(separatedBy: " ")[2].components(separatedBy: "=")[1])!
            
            let result = computeMinCostMatrix(X: X+10000000000000, Y: Y+10000000000000)
            if (result < Int.max) {
                sum += result
            }
        }

        print(sum)
    }
    
    func part1() {
        let lines = Helpers().readFile(fileName: "Day13Input")
        
        var sum = 0
        for i in 0..<(lines.count+1)/4 {
            let buttonA = lines[i*4]
            /// drop comma from end of string
            a = Int(buttonA.components(separatedBy: " ")[2].components(separatedBy: "+")[1].dropLast())!
            b = Int(buttonA.components(separatedBy: " ")[3].components(separatedBy: "+")[1])!
            let buttonB = lines[i*4+1]
            c = Int(buttonB.components(separatedBy: " ")[2].components(separatedBy: "+")[1].dropLast())!
            d = Int(buttonB.components(separatedBy: " ")[3].components(separatedBy: "+")[1])!
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
    
    func computeMinCostMatrix(X: Int, Y: Int) -> Int {
        let determinant = a*d - b*c
        let adjoint = [[d, -b], [-c, a]]
        let xy = [X, Y]
        let result = [
            (adjoint[0][0] * xy[0] + adjoint[0][1] * xy[1]) / determinant,
            (adjoint[1][0] * xy[0] + adjoint[1][1] * xy[1]) / determinant
        ]
        if (result[0]*a + result[1]*b != X || result[0]*c + result[1]*d != Y) {
            return Int.max
        }
        
        return result[0] * A + result[1] * B
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
            return Int(cachedResult)
        }
        
        let result = min(computeMinCost(X: X-a, Y: Y-b, accCost: accCost+A, itrA: itrA+1, itrB: itrB),
                   computeMinCost(X: X-c, Y: Y-d, accCost: accCost+B, itrA: itrA, itrB: itrB+1))
            
        memo[key] = Int64(result)
        return result
    }
}
