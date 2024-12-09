//
//  Day9Solution.swift
//  AdventOfCode2024
//
//  Created by Sarah Deitke on 12/9/24.
//
import Foundation

public class Day9Solution {
    func part2() {
        let line = Helpers().readFile(fileName: "Day9Input")[0]
    }
    
    func part1() {
        let line = Helpers().readFile(fileName: "Day9Input")[0]
        var disk = [Int]()
        
        /// build initial disk
        var (initialDisk, freeSpace) = buildInitialDisk(line: line)
        
        var isFillingFreeSpace = false
        while (!initialDisk.isEmpty) {
            /// build from front
            if (!isFillingFreeSpace) {
                let start = initialDisk.removeFirst()
                for _ in 0..<start[1] {
                    disk.append(start[0])
                }
            }
            else {
                let fS = freeSpace.removeFirst()
                (disk, initialDisk) = appendFreeSpace(disk: disk, freeSpace: fS, initialDisk: initialDisk)
            }
            
            isFillingFreeSpace = !isFillingFreeSpace
        }
        
        var checkSum = 0
        /// compute checksum
        for i in 0..<disk.count {
            checkSum += disk[i]*i
        }

        print("Check Sum: ", checkSum)
    }
    
    func buildInitialDisk(line: String) -> ([[Int]], [Int]) {
        var initialDisk = [[Int]]()
        var freeSpace = [Int]()
        for i in 0..<line.count {
            let char = line[line.index(line.startIndex, offsetBy: i)]
            let num = Int(String(char))!

            if (i % 2 == 0) {
                /// [value, count]
                initialDisk.append([i/2, num])
            }
            else {
                /// amount of free space
                freeSpace.append(num)
            }
        }
        return (initialDisk, freeSpace)
    }
    
    func appendFreeSpace(disk: [Int], freeSpace: Int, initialDisk: Array<[Int]>) -> ([Int], [[Int]]) {
        var disk = disk
        var initialDisk = initialDisk
        var freeSpace = freeSpace
        var endRemainder = 0
        var end = [Int]()
        
        while (freeSpace > 0) {
            end = initialDisk.popLast()!
            endRemainder = end[1]
            for _ in 0..<end[1] {
                disk.append(end[0])
                freeSpace -= 1
                endRemainder -= 1
                if (freeSpace == 0) {
                    break
                }
            }
        }
        
        if (endRemainder > 0) {
            initialDisk.append([end[0], endRemainder])
        }
        
        
        return (disk, initialDisk)
    }
}
