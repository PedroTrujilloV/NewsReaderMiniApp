import Foundation
import Combine
import CoreData
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    private(set) var isReachable: Bool = false
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isReachable = path.status == .satisfied
        }
        
        monitor.start(queue: queue)
    }
}

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
    private let persistentContainer: NSPersistentContainer
    
    var sourceOfTruth: [Article] = [] {
        didSet{
            self.dataModelSubject.send( sourceOfTruth )
            self.saveArticlesToCoreData( sourceOfTruth )
        }
    }

    var dataModel: AnyPublisher<[Article], Never> { dataModelSubject.eraseToAnyPublisher() }
    var isLoadingNextPage: AnyPublisher<Bool, Never> { isLoadingNextPageSubject.eraseToAnyPublisher() }
    
    init<SchedulerType: Scheduler>(apiService: APIService, 
                                   pager: Pagination = Pagination(requestedCount: 0, contentOverrides: [:], remainingCount: 0, uuids: ""),
                                   scheduler: SchedulerType,
                                   persistentContainer: NSPersistentContainer ) {
        self.apiService = apiService
        self.pager = pager
        self.scheduler = scheduler
        self.persistentContainer = persistentContainer
        
        loadCachedArticles()
    }
    
    private func updateSourceOfTruth(with newsStreamResponse: NewsStreamResponse) {
        self.updateSourceOfTruth(with: newsStreamResponse.data.topNewsStream.stream)
    }
    
    private func updateSourceOfTruth(with articles: [Article]) {
        self.sourceOfTruth.append(contentsOf: articles)
        self.sourceOfTruth.removeDuplicates()
        self.isLoadingNextPageSubject.send(false)
    }
    
    func fetchNewsStream(with snippetCount: Int = 10 ){
        self.isLoadingNextPageSubject.send(true)
        apiService.fetchNewsStream(snippetCount: String(snippetCount))
            .decode(type: NewsStreamResponse.self, decoder: JSONDecoder())
            .receive(on: scheduler)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    // Handle successful completion (if needed)
                    break
                case .failure(let error):
                    print("fetchNewsStream Received error: \(error)")
                    // Attempt to load cached articles from CoreData
                    self?.loadCachedArticles()
                }
            }, receiveValue: { [weak self] newsStreamResponse in
                self?.pager =  newsStreamResponse.data.topNewsStream.pagination
                self?.updateSourceOfTruth(with: newsStreamResponse)
            })
            .store(in: &cancellables)

    }
    
    func fetchNextPage() {
        self.isLoadingNextPageSubject.send(true)
        apiService.fetchNextPage(pager: self.pager, snippetCount: "10")
            .decode(type: NewsStreamResponse.self, decoder: JSONDecoder())
            .receive(on: scheduler)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    // Handle successful completion (if needed)
                    break
                case .failure(let error):
                    print("fetchNextPage Received error: \(error)")
                    // Attempt to load cached articles from CoreData
                    self?.loadCachedArticles()
                }
            }, receiveValue: { [weak self] newsStreamResponse in
                self?.pager =  newsStreamResponse.data.topNewsStream.pagination
                self?.updateSourceOfTruth(with: newsStreamResponse)
            })
             .store(in: &cancellables)
    }
}

//
//  NewsStreamRepository+CoreData.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/21/24.
//

extension NewsStreamRepositoryImplementation {
    
    private func saveArticlesToCoreData(_ articles: [Article]) {
        persistentContainer.performBackgroundTask { [weak self] context in
            for article in articles {
                let articleEntity = ArticleEntity(context: context)
                articleEntity.id = article.id
                articleEntity.type = article.type
                articleEntity.content = self?.encodedJSONStringFrom(content: article.content ) ?? "error"
                
                // Save the article entity
                do {
                    try context.save()
                } catch {
                    print("🔴 Error saving article to Core Data: \(error)")
                }
            }
        }
    }
    
    private func loadCachedArticles() {
        persistentContainer.performBackgroundTask { [weak self] context in
            do {
                let fetchRequest: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
                let cachedArticles = try context.fetch(fetchRequest)
                
                // Convert fetched ArticleEntity objects to Article structs without nil articles
                let articles = cachedArticles.compactMap { [weak self] articleEntity -> Article? in
                    // Map ArticleEntity properties to Article struct
                    guard let articleEntityContent = articleEntity.content else {
                        print("🔴 loadCachedArticles: articleEntity.content == nil id: \(articleEntity.id)")
                        return nil
                    }
                    guard let content = self?.decodedContentObjectFrom(jsonString: articleEntityContent) else {
                        print("🔴 loadCachedArticles: Unable to decodedContentObjectFrom articleEntity.content id: \(articleEntity.id)")
                        return nil
                    }
                    let article = Article(
                        id: articleEntity.id,
                        type: articleEntity.type,
                        content: content
                    )
                    return article
                }
                
                // Update sourceOfTruth with cached articles
                DispatchQueue.main.async {
                    self?.updateSourceOfTruth(with: articles)
                }
            } catch {
                print("🔴 Error fetching articles from Core Data: \(error)")
            }
        }
    }
    
    private func encodedJSONStringFrom(content: Content) -> String {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted // Optional: Makes the JSON output readable
            let jsonData = try encoder.encode(content)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                return  jsonString
            } else {
                print("🔴 Failed to convert JSON data to string.")
                return "error"
            }
        } catch {
            print("🔴 Error encoding person object: \(error)")
            return "error"
        }
    }
    
    private func decodedContentObjectFrom(jsonString: String) -> Content? {
        do {
            let jsonData = jsonString.data(using: .utf8)!
            let decoder = JSONDecoder()
            let content = try decoder.decode(Content.self, from: jsonData)
            print("Name: \(content.title), date: \(content.pubDate)")
            return content
        } catch {
            print("🔴 Error decoding JSON string: \(error)")
            return nil
        }
    }
}


