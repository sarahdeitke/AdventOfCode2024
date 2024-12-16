//
//  ContentView.swift
//  AdventOfCode2024
//
//  Created by Sarah Deitke on 12/1/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            Day11Solution().part2();
        }
    }
}

#Preview {
    ContentView()
}
