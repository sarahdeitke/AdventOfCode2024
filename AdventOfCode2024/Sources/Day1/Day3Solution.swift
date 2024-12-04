//
//  Day3Solution.swift
//  AdventOfCode2024
//
//  Created by Sarah Deitke on 12/3/24.
//
import Foundation

public class Day3Solution {
    func part1 () {
        /// read txt file
        let fileURL = Bundle.main.url(forResource: "Day3Input", withExtension: "txt")
        let content = try! String(contentsOf: fileURL!, encoding: .utf8)
        let lines = content.components(separatedBy: .newlines)
        
        /// get corrupt input into string
        var corruptInput = ""
        for i in 0..<lines.count {
            corruptInput += lines[i]
        }
        
        /// filter corrupt input
        let range = NSRange(location: 0, length: corruptInput.utf16.count)
        let regex = try! NSRegularExpression(pattern: "mul\\(\\d{1,3},\\d{1,3}\\)")
        let validMultipleMatches = regex.matches(in: corruptInput, range: range)
        
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
}
