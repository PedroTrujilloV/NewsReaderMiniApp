//
//  ArticleViewModel.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/19/24.
//

import Foundation

class ArticleViewModel: ObservableObject, Identifiable {
    @Published var thumbnailURL: URL?
    @Published var provider: String
    @Published var title: String
    @Published var subheadline: String
    @Published var resolution: CGSize
    @Published var publishedDate: Date
    @Published var publishedDateString: String
    
    private let dateFormatter = DateFormatter()
    private var identifier: UUID
        
    init(article: Article) {
        self.identifier = UUID(uuidString: article.id)!
        let smallerResolution = article.content.thumbnail.resolutions.min { $0.height < $1.height }
        thumbnailURL = URL(string: smallerResolution?.url ?? article.content.thumbnail.originalUrl)
        resolution = CGSize(width: smallerResolution?.width ?? 100 , height: smallerResolution?.height ?? 100)
        provider = article.content.provider.displayName
        title = article.content.title
        subheadline = article.content.subheadline
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // 2024-04-19T14:43:32Z
        let newDate = dateFormatter.date(from:article.content.pubDate) ?? Date()
        publishedDate = newDate
        dateFormatter.dateStyle = .short
        publishedDateString = dateFormatter.string(from: newDate)
        
    }
    
    // TO - DO: Add methods for loading, error handling, etc.
}

extension ArticleViewModel: Equatable {
    static func == (lhs: ArticleViewModel, rhs: ArticleViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
