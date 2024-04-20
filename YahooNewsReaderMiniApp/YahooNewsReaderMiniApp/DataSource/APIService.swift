//
//  APIService.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/20/24.
//

import Foundation
import Combine

class APIService {
    
    private let baseURL = "https://ncp-gw-sports.media.yahoo.com/api/v1/gql/stream_view"
    
    private func makeComponents(with snippetCount: String = "10" ) -> URLComponents {
        // Create a URLComponents instance and set the query items
        let parameters = [
            "id": "topnews",
            "namespace": "sports",
            "lang": "en-US",
            "region": "US",
            "caasAppName": "sportsV2",
            "subsite": "mobile-app",
            "version": "v4",
            "thumbnailSizes": "750,320x240,750x",
            "snippetCount": snippetCount
        ]
        
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return urlComponents
    }

    func fetchData(request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .mapError { error in
                error as Error
            }
            .eraseToAnyPublisher()
    }
    
    func fetchNewsStream(snippetCount: String = "10" ) -> AnyPublisher<Data, Error> {
        let urlComponents = makeComponents(with: snippetCount)
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        return fetchData(request: request)
    }
    
    func fetchNextPage(pager: Pagination, snippetCount: String = "10" ) -> AnyPublisher<Data, Error> {
        let urlComponents = makeComponents(with: snippetCount)
        // Construct the request body for fetching the next page
        let requestBody: [String: Any] = [
            "gqlVariables": [
                "topNewsStream": [
                    "pagination": [
                        "requestedCount": pager.requestedCount,
                        "contentOverrides": [:],
                        "remainingCount": pager.remainingCount,
                        "uuids": pager.uuids
                    ]
                ]
            ]
        ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            let error = NSError(domain: "SerializationError", code: 0, userInfo: nil)
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return fetchData(request: request)
    }
}
