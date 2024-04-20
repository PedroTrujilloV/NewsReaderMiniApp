//
//  NewsStreamViewModel+Mock.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/19/24.
//

import Foundation


extension NewsStreamViewModel {
    func mock() {
        articleViewModels = [ArticleViewModel(article: Article.mock()),ArticleViewModel(article: Article.mock()),ArticleViewModel(article: Article.mock()),ArticleViewModel(article: Article.mock()),ArticleViewModel(article: Article.mock()),ArticleViewModel(article: Article.mock()),ArticleViewModel(article: Article.mock()),ArticleViewModel(article: Article.mock()),ArticleViewModel(article: Article.mock()),ArticleViewModel(article: Article.mock()),ArticleViewModel(article: Article.mock()),ArticleViewModel(article: Article.mock())]
    }
}
