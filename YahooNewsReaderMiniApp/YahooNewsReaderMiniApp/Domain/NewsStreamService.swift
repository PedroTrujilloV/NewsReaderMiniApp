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
    func refresh()
    func scrollDown()
    func openArticle(articleId: String)
}

class NewsStreamServiceImplementation: NewsStreamService {
    typealias Scheduler = DispatchQueue
    
    private let streamSubject = PassthroughSubject<[Article], Never>()
    private let repository: NewsStreamRepository
    private var cancellables = Set<AnyCancellable>()
    
    var streamPublisher: AnyPublisher<[Article], Never> { streamSubject.eraseToAnyPublisher()}
    
    public init<SchedulerType: Scheduler>(repository: NewsStreamRepository, scheduler: SchedulerType = .main) {
        self.repository = repository
        self.bindDataModel(scheduler: scheduler)
    }
    
    private func bindDataModel<SchedulerType: Scheduler>(scheduler: SchedulerType) {
        self.repository
            .dataModel
            .receive(on: scheduler)
            .sink { print ("bindDataModel Received completion: \($0).") }
            receiveValue: { [weak self]  articles in
                self?.streamSubject.send(articles)
            }
            .store(in: &cancellables)
    }
    
    func refresh() {
        repository.fetchNewsStream(with: 11)
    }
    
    func scrollDown() {
        repository.fetchNextPage()
    }
    
    func openArticle(articleId: String) {
        
    }
    
}
