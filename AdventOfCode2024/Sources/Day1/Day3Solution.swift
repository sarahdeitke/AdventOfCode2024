//
//  Day3Solution.swift
//  AdventOfCode2024
//
//  Created by Sarah Deitke on 12/3/24.
//
import Foundation

public class Day3Solution {
    func part1 () {
        let lines = readTextFile()
        
        let corruptInput = buildCorruptInput(lines: lines)
        
        let validMultipleMatches = filterCorruptInput(input: corruptInput, regexPattern: "mul\\(\\d{1,3},\\d{1,3}\\)")
        
        var sum = 0
        
        /// do computation
        for i in 0..<validMultipleMatches.count {
            let idx = validMultipleMatches[i].range.location + 4 // the +4 accounts for the mul( characters
            let len = validMultipleMatches[i].range.length - 5 // the -1 accounts for the ) character and the drop of the 4 prev characters from start
            let start = corruptInput.index(corruptInput.startIndex, offsetBy: idx)
            let end = corruptInput.index(start, offsetBy: len)
            let range = start..<end

            let m = String(corruptInput[range])
            
            let split = m.components(separatedBy: ",")
            sum += Int(split[0])! * Int(split[1])!
        }
        
        print(sum)
    }
    
    func part2 () {
        let lines = readTextFile()
        
        let corruptInput = buildCorruptInput(lines: lines)
        
        let validMultipleMatches = filterCorruptInput(input: corruptInput, regexPattern: "mul\\(\\d{1,3},\\d{1,3}\\)|do\\(\\)|don't\\(\\)")
        
        var sum = 0
        var isDisabled = false
        
        for i in 0..<validMultipleMatches.count {
            let idx = validMultipleMatches[i].range.location
            let len = validMultipleMatches[i].range.length
            let start = corruptInput.index(corruptInput.startIndex, offsetBy: idx)
            let end = corruptInput.index(start, offsetBy: len)
            let range = start..<end

            var m = String(corruptInput[range])
            
            if (m == "do()") {
                isDisabled = false
            } else if (m == "don't()") {
                isDisabled = true
            }
            else {
                if (isDisabled) {
                    continue
                }
                m = m.replacingOccurrences(of: "mul(", with: "")
                m = m.replacingOccurrences(of: ")", with: "")
                let split = m.components(separatedBy: ",")
                sum += Int(split[0])! * Int(split[1])!
            }
        }
        
        print(sum)
    }
    
    func filterCorruptInput (input: String, regexPattern: String) -> [NSTextCheckingResult] {
        let range = NSRange(location: 0, length: input.utf16.count)
        let regex = try! NSRegularExpression(pattern: regexPattern)
        return regex.matches(in: input, range: range)
    }
    
    func buildCorruptInput (lines: [String]) -> String {
        var corruptInput = ""
        for i in 0..<lines.count {
            corruptInput += lines[i]
        }
        return corruptInput
    }
    
    func readTextFile () -> [String] {
        let fileURL = Bundle.main.url(forResource: "Day3Input", withExtension: "txt")
        let content = try! String(contentsOf: fileURL!, encoding: .utf8)
        let lines = content.components(separatedBy: .newlines)
        return lines
    }
}
