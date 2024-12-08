//
//  Day8Solution.swift
//  AdventOfCode2024
//
//  Created by Sarah Deitke on 12/8/24.
//
import Foundation

public class Day8Solution {
    func part1() {
        let map = Helpers().readFile(fileName: "Day8Input").map { Array($0) }
        
        let antennaLocations = buildAntennaLocations(map: map)
        let rows = map.count
        let cols = map[0].count
        
        var locs = Set<[Int]>()
        
        for antennaType in antennaLocations.keys {
            let antennas = antennaLocations[antennaType]!
            for i in 0..<antennas.count {
                let antenna1 = antennas[i]
                for j in i+1..<antennas.count {
                    let antenna2 = antennas[j]
                    
                    let antedoteLocs = computeAntedoteLocationsBetweenTwoAntennas(antenna1: antenna1, antenna2: antenna2, rows: rows, cols: cols)
                    for loc in antedoteLocs {
                        locs.insert(loc)
                    }
                }
            }
        }
        
        print(locs.count)
    }
    
    func computeAntedoteLocationsBetweenTwoAntennas(antenna1: [Int], antenna2: [Int], rows: Int, cols: Int) -> [[Int]] {
        var antennaLocations = [[Int]]()
        
        let verticalDistance = abs(antenna1[0] - antenna2[0])
        let horizontalDistance = abs(antenna1[1] - antenna2[1])
        
        let antedoteLoc1: [Int]
        let antedoteLoc2: [Int]
        
        /// left diagonal
        if (antenna2[0] - antenna1[0] > 0 && antenna2[1] - antenna1[1] > 0) {
            
            antedoteLoc1 = [antenna1[0] - verticalDistance, antenna1[1] - horizontalDistance]
            antedoteLoc2 = [antenna2[0] + verticalDistance, antenna2[1] + horizontalDistance]
        }
        else {
            antedoteLoc1 = [antenna1[0] - verticalDistance, antenna1[1] + horizontalDistance]
            antedoteLoc2 = [antenna2[0] + verticalDistance, antenna2[1] - horizontalDistance]
        }

        if (isValidLoc(loc: antedoteLoc1, rows: rows, cols: cols)) {
            antennaLocations.append(antedoteLoc1)
        }
        if (isValidLoc(loc: antedoteLoc2, rows: rows, cols: cols)) {
            antennaLocations.append(antedoteLoc2)
        }
        
        return antennaLocations
    }
    
    func isValidLoc(loc: [Int], rows: Int, cols: Int) -> Bool {
        return loc[0] >= 0 && loc[0] < rows && loc[1] >= 0 && loc[1] < cols
    }
    
    func buildAntennaLocations(map: [[Character]]) -> [Character: [[Int]]] {
        var antennaLocations = [Character: [[Int]]]()
        
        for row in 0..<map.count {
            for col in map[row].indices {
                if map[row][col] != "." && map[row][col] != "#" {
                    let c = map[row][col]
                    if antennaLocations[c] == nil {
                        antennaLocations[c] = [[row, col]]
                    }
                    else {
                        antennaLocations[c]!.append([row, col])
                    }
                }
            }
        }
        
        return antennaLocations
    }
}
