//
//  NewsStreamViewModel.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/19/24.
//

import Foundation
import Combine
import SwiftUI

// NewsStreamViewModel to manage data source and pagination logic
class NewsStreamViewModel: ObservableObject {
    
    typealias Scheduler = DispatchQueue
    @Published var articleViewModels: [ArticleViewModel] = []
    @Published var isLoadingNextPage: Bool = false
    @Published var isRefreshing: Bool = false

    
    private var newsStreamService: NewsStreamService
    private var cancellables = Set<AnyCancellable>()
    
    // TO - DO: Add methods for loading, error handling, etc.
    
    init<SchedulerType: Scheduler>(newsStreamService: NewsStreamService, 
                                   isLoadingNextPage: AnyPublisher<Bool, Never>,
                                   scheduler: SchedulerType) {
        self.newsStreamService = newsStreamService
        self.bindToNewsStreamService(scheduler: scheduler)
        
        isLoadingNextPage
            .receive(on: scheduler)
            .assign(to: &$isLoadingNextPage)
    }
    
    private func bindToNewsStreamService<SchedulerType: Scheduler>(scheduler: SchedulerType){
        
        let sharedNewsStreamServicePublisher = self.newsStreamService.streamPublisher.share()
        
        sharedNewsStreamServicePublisher
            .receive(on: scheduler)
            .map { articles in
                articles.map { ArticleViewModel(article: $0) }
            }
            .receive(on: scheduler)
            .assign(to: &$articleViewModels)
        
        sharedNewsStreamServicePublisher
            .receive(on: scheduler)
            .sink { [weak self] completion in
                self?.isRefreshing = false
            }
            .store(in: &cancellables)
    }
    
    func loadInitialData() {
        refresh()
    }
    
    func refresh() {
        self.isRefreshing = true
        newsStreamService.refresh()
    }

    func reachScrollLimit() {
        newsStreamService.scrollFetching()
    }
}
