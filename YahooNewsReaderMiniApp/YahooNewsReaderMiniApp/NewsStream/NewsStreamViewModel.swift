//
//  NewsStreamViewModel.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/19/24.
//

import Foundation


// NewsStreamViewModel to manage data source and pagination logic
class NewsStreamViewModel: ObservableObject {
    @Published var articleViewModels: [ArticleViewModel] = []
    @Published var isLoadingNextPage: Bool = false
    @Published var isRefreshing: Bool = false
    
    // Pagination logic variables
    private var remainingCount: Int = 0
    private var uuids: [String] = []
    
    // TO - DO: Add methods for loading, error handling, etc.

    // Function to load initial data
    func loadInitialData() {
        // Load data from local JSON file
        if let url = Bundle.main.url(forResource: "mockJSONDataResponse", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(NewsStreamResponse.self, from: jsonData)
                self.remainingCount = response.data.topNewsStream.pagination.remainingCount
                self.uuids = response.data.topNewsStream.pagination.uuids.components(separatedBy: ",")
                self.articleViewModels = response.data.topNewsStream.stream.map { ArticleViewModel(article: $0) }
                    .sorted { $0.publishedDate > $1.publishedDate}
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
    
    // Function to handle pull-to-refresh action
    func refresh() {
        self.isRefreshing = true
        // Simulate refreshing data
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isRefreshing = false
            
            for _ in 0...Int.random(in: 1...3) {
                self.articleViewModels.insert(ArticleViewModel(article: Article.mock()) , at: 0)
            }
            // Clear existing articles and load new data
            //self.articleViewModels.removeAll()
            //self.loadInitialData()
        }
    }
}

// NewsStreamResponse structure to decode the JSON response
struct NewsStreamResponse: Codable {
    let data: NewsStreamData
    let status: String
}

// NewsStreamData structure to decode the data section of the JSON response
struct NewsStreamData: Codable {
    let topNewsStream: TopNewsStream
}

// TopNewsStream structure to decode the topNewsStream section of the JSON response
struct TopNewsStream: Codable {
    let pagination: Pagination
    let stream: [Article]
}

// Pagination structure to decode the pagination section of the JSON response
struct Pagination: Codable {
    let requestedCount: Int
    let contentOverrides: [String: String]
    let remainingCount: Int
    let uuids: String
}
