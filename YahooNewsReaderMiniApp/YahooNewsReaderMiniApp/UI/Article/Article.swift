//
//  Article.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/19/24.
//

import Foundation

struct Article: Codable {
    let id: String
    let type: String
    let content: Content
}

struct Content: Codable {
    let title: String
    let pubDate: String
    let displayTime: String
    let subheadline: String
    let isOpinion: Bool
    let presentation: String?
    let liveBlogStatus: String?
    let heroModule: HeroModule?
    let commentsAllowed: Bool
    let contentType: String
    let isHosted: Bool
    let ampUrl: String?
    let structuredSummary: StructuredSummary?
    let provider: Provider
    let previewUrl: String?
    let providerContentUrl: String
    let canonicalUrl: CanonicalUrl?
    let clickThroughUrl: ClickThroughUrl?
    let author: Author?
    let authors: [Author]?
    let thumbnail: Thumbnail
    let adMeta: AdMeta?
    let canvass: Canvass?
    let readingMeta: ReadingMeta?
    let readMoreList: String?
    let body: Body?
}

struct HeroModule: Codable {
    let darkBackground: Bool
    let headlinePosition: String
    let type: String
}

struct StructuredSummary: Codable {
    let summaries: [Summary]
    let source: String
}

struct Summary: Codable {
    let type: String
    let value: String
}

struct Provider: Codable {
    let url: String
    let displayName: String
    let logo: Logo
    let lightLogo: Logo
    let darkLogo: Logo
}

struct Logo: Codable {
    let type: String?
    let originalUrl: String
    let originalHeight: Int
    let originalWidth: Int
    let resolutions: [Resolution]
}

//enum logoType: Codable {
//    case darklogo
//    case lightlogo
//    case unknow
//}

struct Resolution: Codable {
    let tag: String
    let url: String
    let width: Int
    let height: Int
}

struct CanonicalUrl: Codable {
    let lang: String
    let region: String
    let site: String
    let url: String
}

struct ClickThroughUrl: Codable {
    let lang: String
    let region: String
    let site: String
    let url: String
}

struct Author: Codable {
    let image: Image?
    let byline: String?
    let description: String?
    let displayName: String?
}

struct Image: Codable {
    let originalHeight: Int
    let originalWidth: Int
    let originalUrl: String
    let resolutions: [Resolution]
}

struct Thumbnail: Codable {
    let originalUrl: String
    let originalWidth: Int
    let originalHeight: Int
    let resolutions: [Resolution]
}

struct AdMeta: Codable {
    let siteAttribute: String
    let site: String?
    let spaceId: String
}

struct Canvass: Codable {
    let contextId: String
    let count: Int
}

struct ReadingMeta: Codable {
    let wpm200: Int
}

struct Body: Codable {
    let modules: [String: String] // Update this with the actual structure
    let data: PartnerData?
    let markup: String?
}

struct PartnerData: Codable {
    let adMeta: AdMeta?
    let contentType: String?
    let cover: Cover?
    let hasScribble: Bool?
    let hostedType: String?
    let lastModifiedTime: String?
    let spaceId: String?
    let tpConsent: Bool?
    let type: String?
    let url: String?
    let uuid: String?
}

struct Cover: Codable {
    let image: Image?
}


extension Article: Equatable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.id == rhs.id
    }
}

extension Article: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


