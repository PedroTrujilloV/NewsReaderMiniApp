//
//  ContentView.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/19/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NewsStreamView(viewModel: NewsStreamViewModel())
            .padding( .horizontal,   -20)
    }
} 

#Preview {
    ContentView()
}
