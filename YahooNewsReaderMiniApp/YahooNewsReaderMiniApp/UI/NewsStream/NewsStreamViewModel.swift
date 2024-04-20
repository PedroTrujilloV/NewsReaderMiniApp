//
//  NewsStreamViewModel.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/19/24.
//

import Foundation
import Combine

// NewsStreamViewModel to manage data source and pagination logic
class NewsStreamViewModel: ObservableObject {
    
    typealias Scheduler = DispatchQueue
    @Published var articleViewModels: [ArticleViewModel] = []
    @Published var isLoadingNextPage: Bool = false
    @Published var isRefreshing: Bool = false
    
    private var newsStreamService: NewsStreamService
    private var cancellables = Set<AnyCancellable>()
    
    // TO - DO: Add methods for loading, error handling, etc.
    
    init<SchedulerType: Scheduler>(newsStreamService: NewsStreamService, scheduler: SchedulerType) {
        self.newsStreamService = newsStreamService
        self.bindToNewsStreamService(scheduler: scheduler)
    }
    
    private func bindToNewsStreamService<SchedulerType: Scheduler>(scheduler: SchedulerType){
        self.newsStreamService
            .streamPublisher
            .receive(on: scheduler)
            .map { articles in
                articles.map { ArticleViewModel(article: $0) }
            }
            .receive(on: scheduler)
            .assign(to: &$articleViewModels)
    }
    
    

    // Function to load initial data
    func loadInitialData() {
        // Load data from local JSON file
//        if let url = Bundle.main.url(forResource: "mockJSONDataResponse", withExtension: "json") {
//            do {
//                let jsonData = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(NewsStreamResponse.self, from: jsonData)
//                self.articleViewModels = response.data.topNewsStream.stream.map { ArticleViewModel(article: $0) }
//                    .sorted { $0.publishedDate > $1.publishedDate}
//            } catch {
//                print("Error decoding JSON: \(error)")
//            }
//        }
        newsStreamService.refresh()
    }
    
    // Function to handle pull-to-refresh action
    func refresh() {
//        newsStreamService.refresh()
//        newsStreamService.scrollDown()

//        self.isRefreshing = true
//        // Simulate refreshing data
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.isRefreshing = false
//            
//            for _ in 0...Int.random(in: 1...3) {
//                self.articleViewModels.insert(ArticleViewModel(article: Article.mock()) , at: 0)
//            }
//            // Clear existing articles and load new data
//            //self.articleViewModels.removeAll()
//            //self.loadInitialData()
//        }
    }
}

