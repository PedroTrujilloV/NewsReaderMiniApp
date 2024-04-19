//
//  ArticleViewModel.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/19/24.
//

import Foundation

class ArticleViewModel: ObservableObject {
    @Published var thumbnailURL: URL?
    @Published var provider: String
    @Published var title: String
    @Published var subheadline: String
        
    init(article: Article) {
        thumbnailURL = URL(string: article.content.thumbnail.originalUrl)
        provider = article.content.provider.displayName
        title = article.content.title
        subheadline = article.content.subheadline
    }
    
    // TO - DO: Add methods for loading, error handling, etc.
}
