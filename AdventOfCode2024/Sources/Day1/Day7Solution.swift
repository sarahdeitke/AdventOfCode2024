//
//  Day7Solution.swift
//  AdventOfCode2024
//
//  Created by Sarah Deitke on 12/7/24.
//
import Foundation

public class Day7Solution {
    func part1() {
        let lines = Helpers().readFile(fileName: "Day7Input")
        
        var sum = 0
        
        for line in lines {
            let equation = line.components(separatedBy: ":")
            let inputs = equation[1].trimmingCharacters(in: .whitespaces).components(separatedBy: " ").map { Int($0)! }
            sum += evaluateEquation(total: Int(equation[0])!, inputs: inputs)
        }
        
        print(sum)
    }
    
    func part2() {
        let lines = Helpers().readFile(fileName: "Day7Input")
        
        var sum = 0
        
        for line in lines {
            let equation = line.components(separatedBy: ":")
            let inputs = equation[1].trimmingCharacters(in: .whitespaces).components(separatedBy: " ").map { Int($0)! }
            sum += evaluateEquation(total: Int(equation[0])!, inputs: inputs, isPart2: true)
        }
        
        print(sum)
    }
    
    func evaluateEquation(total: Int, inputs: [Int], isPart2: Bool = false) -> Int {
        var options = [Int]()
        options.append(inputs[0])
        for i in 1..<inputs.count {
            var newOptions = [Int]()
            for option in options {
                newOptions.append(option + inputs[i])
                newOptions.append(option * inputs[i])
                if isPart2 {
                    let optionsStr = String(option)
                    let inputsStr = String(inputs[i])
                    let conCat = optionsStr + inputsStr
                    newOptions.append(Int(conCat)!)
                }
            }
            options = newOptions
        }
        
        for option in options {
            if option == total {
                return total
            }
        }
        return 0
    }
}
