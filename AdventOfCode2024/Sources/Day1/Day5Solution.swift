//
//  Day5Solution.swift
//  AdventOfCode2024
//
//  Created by Sarah Deitke on 12/5/24.
//
import Foundation

public class Day5Solution {
    var parentMap = [Int: Set<Int>]()
    
    func part1() {
        let lines = Helpers().readFile(fileName: "Day5InputParents")
        
        /// build a dictionary where the key is a num and the value is a hashset of its children
        let parentMap = buildParentMap(lines: lines)
        self.parentMap = parentMap
        
        /// print each parents children
//        for (key, value) in parentMap {
//            print("Parent: ", key, "Children: ", value)
//        }
        
        let updates = Helpers().readFile(fileName: "Day5InputUpdates")
        
        var sum = 0
        
        for update in updates {
            let updateSeq = update.components(separatedBy: ",")
            if isValidUpdate(update: updateSeq) {
                let midIdx = updateSeq.count / 2
                let middle = Int(updateSeq[midIdx])!
                sum += middle
            }
        }
        
        print(sum)
    }
    
    func part2() {
        let lines = Helpers().readFile(fileName: "Day5InputParents")
        
        /// build a dictionary where the key is a num and the value is a hashset of its children
        let parentMap = buildParentMap(lines: lines)
        self.parentMap = parentMap
        
        let updates = Helpers().readFile(fileName: "Day5InputUpdates")
        
        var sum = 0
        
        for update in updates {
            let updateSeq = update.components(separatedBy: ",")
            if !isValidUpdate(update: updateSeq) {
                let sortedSeq = sortByParent(update: updateSeq)
                let midIdx = sortedSeq.count / 2
                let middle = Int(sortedSeq[midIdx])!
                sum += middle
            }
        }
        
        print(sum)
    }
    
    func sortByParent(update: [String]) -> [String] {
        var sortedUpdate = update
        var i = 0
        while i < sortedUpdate.count-1 {
            let parent = Int(sortedUpdate[i])!
            let child = Int(sortedUpdate[i+1])!
            
            if !detectChild(parent: parent, child: child) {
                let temp = sortedUpdate[i]
                sortedUpdate[i] = sortedUpdate[i+1]
                sortedUpdate[i+1] = temp
                i = 0 // move back, this could be more efficient but I am lazy
            }
            else {
                i += 1
            }
        }
        
        return sortedUpdate
    }
    
    func isValidUpdate(update: [String]) -> Bool {
        for i in 0..<update.count-1 {
            let parent = Int(update[i])!
            let child = Int(update[i+1])!
            if !detectChild(parent: parent, child: child) {
                return false
            }
        }
        
        return true
    }
    
    func detectChild(parent: Int, child: Int) -> Bool {
        if  self.parentMap.keys.contains(parent) == false {
            return false
        }
        
        if self.parentMap[parent]!.contains(child) {
            return true
        }
        
        return false
    }
    
    func buildParentMap(lines: [String]) -> [Int: Set<Int>] {
        var parentMap = [Int: Set<Int>]()
        
        for line in lines {
            let nums = line.components(separatedBy: "|")
            let parent = Int(nums[0])!
            let child = Int(nums[1])!
            if parentMap[parent] == nil {
                parentMap[parent] = Set<Int>()
            }
            parentMap[parent]!.insert(child)
        }
        
        return parentMap
    }
}
