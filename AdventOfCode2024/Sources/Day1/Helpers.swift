//
//  Helpers.swift
//  AdventOfCode2024
//
//  Created by Sarah Deitke on 12/4/24.
//
import Foundation

public class Helpers {
    func readFile(fileName: String) -> [String] {
        let fileURL = Bundle.main.url(forResource: fileName, withExtension: "txt")
        let content = try! String(contentsOf: fileURL!, encoding: .utf8)
        let lines = content.components(separatedBy: .newlines)
        return lines
    }
}
