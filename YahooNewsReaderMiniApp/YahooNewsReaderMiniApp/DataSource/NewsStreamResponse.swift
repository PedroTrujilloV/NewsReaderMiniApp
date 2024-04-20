//
//  NewsStreamResponse.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/20/24.
//

import Foundation

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
