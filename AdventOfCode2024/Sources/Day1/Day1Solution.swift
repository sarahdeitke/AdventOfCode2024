//
//  Day1Solution.swift
//  AdventOfCode2024
//
//  Created by Sarah Deitke on 12/1/24.
//
import Foundation


/// Day 1 Solution class - Historian Hysteria
class Day1Solution {
    func part1 () {
        /// read txt file
        let fileURL = Bundle.main.url(forResource: "Day1Input", withExtension: "txt")
        let content = try! String(contentsOf: fileURL!, encoding: .utf8)
        let lines = content.components(separatedBy: .newlines)
        
        /// create empty lists for each row
        var list1 = [Int]()
        var list2 = [Int]()

        for i in 0..<lines.count {
            /// split each line by whitespace
            let line = lines[i].components(separatedBy: "   ")
            list1.append(Int(line[0])!)
            list2.append(Int(line[1])!)
        }
        
        /// sort each list in ascending order
        list1.sort()
        list2.sort()
        
        /// sum total
        var total = 0
        
        for i in 0..<list1.count {
            /// compute absolute value between list1[i] and list2[i]
            total += abs(list1[i] - list2[i])
        }
        
        print(total)
    }
    
    func part2 () {
        /// read txt file
        let fileURL = Bundle.main.url(forResource: "Day1Input", withExtension: "txt")
        let content = try! String(contentsOf: fileURL!, encoding: .utf8)
        let lines = content.components(separatedBy: .newlines)
        
        /// create dictionary to store occurences of second row
        var list1 = [Int]()
        var secondRowOcc = [Int: Int]()
        
        for i in 0..<lines.count {
            /// split each line by whitespace
            let line = lines[i].components(separatedBy: "   ")
            
            /// create list for row 1
            list1.append(Int(line[0])!)
            
            /// create dictionary for row 2
            let num = Int(line[1])!
            if secondRowOcc[num] == nil {
                secondRowOcc[num] = 1
            } else {
                secondRowOcc[num]! += 1
            }
        }
        
        var total = 0
        
        for i in 0..<list1.count {
            if secondRowOcc[list1[i]] != nil {
                total += (list1[i] * secondRowOcc[list1[i]]!)
            }
        }
        
        print(total)
    }
}
