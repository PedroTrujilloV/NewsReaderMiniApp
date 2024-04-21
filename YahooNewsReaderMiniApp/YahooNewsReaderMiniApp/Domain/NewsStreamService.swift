//
//  NewsStreamService.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/19/24.
//

import Foundation
import Combine
import SwiftData

protocol NewsStreamService {
    var streamPublisher: AnyPublisher<[Article], Never> { get }
    var isNearBottom: AnyPublisher<Bool, Never> { get }
    func refresh()
    func scrollFetching()
    func openArticle(articleId: String)
}

class NewsStreamServiceImplementation: NewsStreamService {
    
    typealias Scheduler = DispatchQueue
    
    private let streamSubject = PassthroughSubject<[Article], Never>()
    private let isNearBottomSubject = PassthroughSubject<Bool, Never>()

    private let repository: NewsStreamRepository
    private var cancellables = Set<AnyCancellable>()
    
    var streamPublisher: AnyPublisher<[Article], Never> { streamSubject.eraseToAnyPublisher() }
    var isNearBottom: AnyPublisher<Bool, Never> { isNearBottomSubject.eraseToAnyPublisher() }

    
    public init<SchedulerType: Scheduler>(repository: NewsStreamRepository, scheduler: SchedulerType = .main) {
        self.repository = repository
        self.bind(scheduler: scheduler)
    }
    
    private func bind<SchedulerType: Scheduler>(scheduler: SchedulerType) {
        self.repository
            .dataModel
            .receive(on: scheduler)
            .sink { print ("bindDataModel Received completion: \($0).") }
            receiveValue: { [weak self]  articles in
                let sortedArticles = self?.articlesSortedByDate(articles: articles) ?? articles
                self?.streamSubject.send(sortedArticles)
            }
            .store(in: &cancellables)
        
        //Combine isLoadingNextPage and isNearBottom into a single publisher for avoiding multiple pagination requests
        Publishers.CombineLatest(self.repository.isLoadingNextPage, self.isNearBottom)
            .debounce(for: 0.5, scheduler: scheduler) // Debounce to avoid rapid firing
            .map { isLoadingNextPage, isNearBottom in
                //print("isNearBottomSubject: \(isNearBottom) && isLoadingNextPage: \(isLoadingNextPage)")
                return !isLoadingNextPage && isNearBottom
            }
            .sink { [weak self] value in
                if value {
                    self?.repository.fetchNextPage()  // Fetch next page if near bottom
                    self?.isNearBottomSubject.send(false)
                }
            }
            .store(in: &cancellables)
    }
    
    private func articlesSortedByDate(articles: [Article]) -> [Article] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // 2024-04-19T14:43:32Z
        return articles.sorted { articleA, articleB in
            let dateA = dateFormatter.date(from:articleA.content.pubDate) ?? Date()
            let dateB = dateFormatter.date(from:articleB.content.pubDate) ?? Date()
            return dateA > dateB
        }
    }
    
    func refresh() {
        repository.fetchNewsStream(with: 11)
    }
    
    func scrollFetching() {
        self.isNearBottomSubject.send(true)
    }
    
    func openArticle(articleId: String) {
        
    }
    
}
