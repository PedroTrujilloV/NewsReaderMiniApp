//
//  NewsStreamRepository.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/20/24.
//

import Foundation
import Combine
import SwiftData

protocol NewsStreamRepository {
    var dataModel: AnyPublisher<[Article], Never> { get }
    var isLoadingNextPage: AnyPublisher<Bool, Never> { get }
    func fetchNewsStream( with snippetCount: Int)
    func fetchNextPage()
}

class NewsStreamRepositoryImplementation: NewsStreamRepository {
    
    typealias Scheduler = DispatchQueue

    private let apiService: APIService
    private var cancellables = Set<AnyCancellable>()
    private let dataModelSubject = PassthroughSubject<[Article], Never>()
    private let isLoadingNextPageSubject = PassthroughSubject<Bool, Never>()
    private let scheduler: Scheduler
    private var pager: Pagination
    
    private var sourceOfTruth: [Article] = [] {
        didSet{
            self.dataModelSubject.send( sourceOfTruth )
        }
    }

    var dataModel: AnyPublisher<[Article], Never> { dataModelSubject.eraseToAnyPublisher() }
    var isLoadingNextPage: AnyPublisher<Bool, Never> { isLoadingNextPageSubject.eraseToAnyPublisher() }
    
    init<SchedulerType: Scheduler>(apiService: APIService, 
                                   pager: Pagination = Pagination(requestedCount: 0, contentOverrides: [:], remainingCount: 0, uuids: ""),
                                   scheduler: SchedulerType) {
        self.apiService = apiService
        self.pager = pager
        self.scheduler = scheduler
    }
    
    private func updateSourceOfTruth(with newsStreamResponse: NewsStreamResponse) {
        self.pager =  newsStreamResponse.data.topNewsStream.pagination
        self.sourceOfTruth.append(contentsOf: newsStreamResponse.data.topNewsStream.stream)
        self.sourceOfTruth.removeDuplicates()
        self.isLoadingNextPageSubject.send(false)
    }
    
    func fetchNewsStream(with snippetCount: Int = 10 ){
        self.isLoadingNextPageSubject.send(true)
        apiService.fetchNewsStream(snippetCount: String(snippetCount))
            .decode(type: NewsStreamResponse.self, decoder: JSONDecoder())
            .receive(on: scheduler)
            .sink { print ("fetchNewsStream Received completion: \($0).") }
             receiveValue: { [weak self] newsStreamResponse in
                 self?.updateSourceOfTruth(with: newsStreamResponse)
             }
             .store(in: &cancellables)
    }
    
    func fetchNextPage() {
        self.isLoadingNextPageSubject.send(true)
        apiService.fetchNextPage(pager: self.pager, snippetCount: "10")
            .decode(type: NewsStreamResponse.self, decoder: JSONDecoder())
            .receive(on: scheduler)
            .sink { print ("fetchNextPage Received completion: \($0).") }
             receiveValue: {  [weak self] newsStreamResponse in
                 self?.updateSourceOfTruth(with: newsStreamResponse)
             }
             .store(in: &cancellables)
    }
}


//    private var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Article.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    
//@Model
//final class DataModel {
//    var timestamp: Date
//
//    init(timestamp: Date) {
//        self.timestamp = timestamp
//    }
//}






