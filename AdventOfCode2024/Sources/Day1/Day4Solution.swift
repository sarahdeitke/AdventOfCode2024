//
//  Day4Solution.swift
//  AdventOfCode2024
//
//  Created by Sarah Deitke on 12/4/24.
//
import Foundation

public class Day4Solution {
    func part1 () {
        let lines = Helpers().readFile(fileName: "Day4Input")
        
        var count = 0;
        
        /// navigate through the field to find X
        for row in 0..<lines.count {
            let line = lines[row]
            for col in line.indices {
                if line[col] == "X" {
                    count += computeXMASCount(row: row, col: col, lines: lines)
//                    let colIndex = line.distance(from: line.startIndex, to: col)
//                    print("row: ", row, "col: ", colIndex, "count: ", count)
                }
            }
        }
        
        print(count)
    }
    
    func computeXMASCount (row: Int, col: String.Index, lines: [String]) -> Int {
        // check the 8 directions
        var singleCount = 0
        
        let dirs = [[0, 1], [1, 0], [1, 1], [-1, 0], [0, -1], [-1, -1], [1, -1], [-1, 1]]
        
        for dir in dirs {
            let row1 = row + dir[0]
            let row2 = row1 + dir[0]
            let row3 = row2 + dir[0]
            /// assumes all rows are the same length
            let col1 = lines[0].distance(from: lines[0].startIndex, to: col) + dir[1]
            let col2 = col1 + dir[1]
            let col3 = col2 + dir[1]
            

            guard row1 >= 0, row1 < lines.count,
                  row2 >= 0, row2 < lines.count,
                  row3 >= 0, row3 < lines.count,
                  col1 >= 0, col1 < lines[0].count,
                  col2 >= 0, col2 < lines[0].count,
                  col3 >= 0, col3 < lines[0].count
                  
            else {
                continue
            }
            
            let col1Index = lines[0].index(lines[0].startIndex, offsetBy: col1)
            let col2Index = lines[0].index(lines[0].startIndex, offsetBy: col2)
            let col3Index = lines[0].index(lines[0].startIndex, offsetBy: col3)

            if (lines[row1][col1Index] == "M" &&
                lines[row2][col2Index] == "A" &&
                lines[row3][col3Index] == "S") {
                singleCount += 1
            }
            
        }
        
        return singleCount
    }
}
