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
                    
                    let antinodeLocs = computeAntinodeLocationsBetweenTwoAntennas(antenna1: antenna1, antenna2: antenna2, rows: rows, cols: cols)
                    for loc in antinodeLocs {
                        locs.insert(loc)
                    }
                }
            }
        }
        
        print(locs.count)
    }
    
    func part2() {
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
                    let antinodeLocs = computeAntinodeLocationsBetweenTwoAntennasWithHarmonics(antenna1: antenna1, antenna2: antenna2, rows: rows, cols: cols)
                    for loc in antinodeLocs {
                        locs.insert(loc)
                    }
                }
            }
        }
        
        print(locs.count)
    }
    
    func computeAntinodeLocationsBetweenTwoAntennasWithHarmonics(antenna1: [Int], antenna2: [Int], rows: Int, cols: Int) -> [[Int]] {
        var antennaLocations = [[Int]]()
        var antenna1 = antenna1
        var antenna2 = antenna2
        antennaLocations.append(antenna1)
        antennaLocations.append(antenna2)
        
        let verticalDistance = abs(antenna1[0] - antenna2[0])
        let horizontalDistance = abs(antenna1[1] - antenna2[1])
        
        var antinodeLoc1: [Int]
        var antinodeLoc2: [Int]
        
        var isValid = true
        
        while (isValid) {
            /// left diagonal
            if (antenna2[0] - antenna1[0] > 0 && antenna2[1] - antenna1[1] > 0) {
                antinodeLoc1 = [antenna1[0] - verticalDistance, antenna1[1] - horizontalDistance]
                antinodeLoc2 = [antenna2[0] + verticalDistance, antenna2[1] + horizontalDistance]
            }
            else {
                antinodeLoc1 = [antenna1[0] - verticalDistance, antenna1[1] + horizontalDistance]
                antinodeLoc2 = [antenna2[0] + verticalDistance, antenna2[1] - horizontalDistance]
            }
                        
            let isAntinode1Valid = isValidLoc(loc: antinodeLoc1, rows: rows, cols: cols)
            let isAntinode2Valid = isValidLoc(loc: antinodeLoc2, rows: rows, cols: cols)
            
            if (isAntinode1Valid) {
                antennaLocations.append(antinodeLoc1)
            }
            if (isAntinode2Valid) {
                antennaLocations.append(antinodeLoc2)
            }
            
            isValid = isAntinode1Valid || isAntinode2Valid
            antenna1 = antinodeLoc1
            antenna2 = antinodeLoc2
        }
                
        return antennaLocations
    }
    
    func computeAntinodeLocationsBetweenTwoAntennas(antenna1: [Int], antenna2: [Int], rows: Int, cols: Int) -> [[Int]] {
        var antennaLocations = [[Int]]()
        
        let verticalDistance = abs(antenna1[0] - antenna2[0])
        let horizontalDistance = abs(antenna1[1] - antenna2[1])
        
        let antinodeLoc1: [Int]
        let antinodeLoc2: [Int]
        
        /// left diagonal
        if (antenna2[0] - antenna1[0] > 0 && antenna2[1] - antenna1[1] > 0) {
            antinodeLoc1 = [antenna1[0] - verticalDistance, antenna1[1] - horizontalDistance]
            antinodeLoc2 = [antenna2[0] + verticalDistance, antenna2[1] + horizontalDistance]
        }
        else {
            antinodeLoc1 = [antenna1[0] - verticalDistance, antenna1[1] + horizontalDistance]
            antinodeLoc2 = [antenna2[0] + verticalDistance, antenna2[1] - horizontalDistance]
        }

        if (isValidLoc(loc: antinodeLoc1, rows: rows, cols: cols)) {
            antennaLocations.append(antinodeLoc1)
        }
        if (isValidLoc(loc: antinodeLoc2, rows: rows, cols: cols)) {
            antennaLocations.append(antinodeLoc2)
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
