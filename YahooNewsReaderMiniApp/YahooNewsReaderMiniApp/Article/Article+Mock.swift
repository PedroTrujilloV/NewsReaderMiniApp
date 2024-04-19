//
//  Article+Mock.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/19/24.
//

import Foundation


extension Article {
    
    static func mock() -> Article {
        // Define values for all the properties
        let id = "caad1e5a-5e70-4909-a194-9e1b8c61c577"
        let type = "CONTENT"
        // Define values for other properties...
        
        // Create an instance of the Article model
        let article = Article(id: id, type: type, content: Content.mock() )
        
        // Return the Article instance
        return article
    }

}

extension Content {
    
    static func mock() -> Content {
        // Define values for all the properties
        let title = "AJ Simon, Albany defensive standout and NFL draft prospect, dies at 25"
        let pubDate = Date()
        let displayTime = Date()
        let subheadline = "Simon had visited with the Patriots ahead of next week's NFL draft."
        let isOpinion = false
        let presentation: String? = nil
        let liveBlogStatus: String? = nil
        let heroModule: HeroModule? = nil
        let commentsAllowed = true
        let contentType = "STORY"
        let isHosted = true
        let ampUrl = ""
        let structuredSummary: StructuredSummary? =  nil
        let provider: Provider = Provider.mock()
        let previewUrl: String? = ""
        let providerContentUrl = ""
        let canonicalUrl: CanonicalUrl? = nil
        let clickThroughUrl: ClickThroughUrl? = nil
        let author: Author? = nil
        let authors: [Author] = []
        let thumbnail: Thumbnail = Thumbnail.mock()
        let adMeta: AdMeta? = nil
        let canvass: Canvass? = nil
        let readingMeta: ReadingMeta? = nil
        let readMoreList = ""
        let body: Body? = nil
        
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        
        // Create an instance of the Content model
        let content = Content(title: title, pubDate: formatter1.string(from: pubDate), displayTime: formatter1.string(from: displayTime), subheadline: subheadline, isOpinion: isOpinion, presentation: presentation, liveBlogStatus: liveBlogStatus, heroModule: heroModule, commentsAllowed: commentsAllowed, contentType: contentType, isHosted: isHosted, ampUrl: ampUrl, structuredSummary: structuredSummary, provider: provider, previewUrl: previewUrl, providerContentUrl: providerContentUrl, canonicalUrl: canonicalUrl, clickThroughUrl: clickThroughUrl, author: author, authors: authors, thumbnail: thumbnail, adMeta: adMeta, canvass: canvass, readingMeta: readingMeta, readMoreList: readMoreList, body: body)
        
        // Return the Content instance
        return content
    }
    
}


// Dummy data for the Provider model
extension Provider {
    static func mock() -> Provider {
        // Define values for the Provider model
        let url = "https://sports.yahoo.com/"
        let displayName = "Yahoo Sports"
        let logo = Logo(type: "lightlogo", originalUrl: "https://s.yimg.com/os/creatr-uploaded-images/2021-02/b6728df0-6bdc-11eb-b7bd-913b7afc7515", originalHeight: 400, originalWidth: 400, resolutions: [
            Resolution(tag: "original", url: "https://s.yimg.com/uu/api/res/1.2/2lVDVggwaje9HT.QojjqWA--~B/aD00MDA7dz00MDA7YXBwaWQ9eXRhY2h5b24-/https://s.yimg.com/os/creatr-uploaded-images/2021-02/b6728df0-6bdc-11eb-b7bd-913b7afc7515", width: 400, height: 400),
            Resolution(tag: "100x50", url: "https://s.yimg.com/uu/api/res/1.2/OfyjfiwFG_W4Dqwyad2vcw--~B/Zmk9ZmlsbDtoPTUwO3B5b2ZmPTA7dz0xMDA7YXBwaWQ9eXRhY2h5b24-/https://s.yimg.com/os/creatr-uploaded-images/2021-02/b6728df0-6bdc-11eb-b7bd-913b7afc7515", width: 100, height: 50)
        ])
        
        let lightLogo = Logo( type: "lightlogo", originalUrl: "https://s.yimg.com/os/creatr-uploaded-images/2021-02/d6cfeca0-6bdc-11eb-9fff-072dbeffa160", originalHeight: 100, originalWidth: 469, resolutions: [
            Resolution(tag: "original", url: "https://s.yimg.com/uu/api/res/1.2/F1BfKNybxRwKZSbWsVVdAw--~B/aD0xMDA7dz00Njk7YXBwaWQ9eXRhY2h5b24-/https://s.yimg.com/os/creatr-uploaded-images/2021-02/d6cfeca0-6bdc-11eb-9fff-072dbeffa160", width: 469, height: 100),
            Resolution(tag: "100x50", url: "https://s.yimg.com/uu/api/res/1.2/tv97T9BRLtnTtOL3dBusIQ--~B/Zmk9ZmlsbDtoPTUwO3B5b2ZmPTA7dz0xMDA7YXBwaWQ9eXRhY2h5b24-/https://s.yimg.com/os/creatr-uploaded-images/2021-02/d6cfeca0-6bdc-11eb-9fff-072dbeffa160", width: 100, height: 50)
        ])
        let darkLogo = Logo( type: "darklogo", originalUrl: "https://s.yimg.com/os/creatr-uploaded-images/2021-02/eea32ae0-6bdc-11eb-bf5e-5d7f15d13ff6", originalHeight: 100, originalWidth: 513,  resolutions: [
            Resolution(tag: "original", url: "https://s.yimg.com/uu/api/res/1.2/L5r8ccvvGTp4fcoafLKCAg--~B/aD0xMDA7dz01MTM7YXBwaWQ9eXRhY2h5b24-/https://s.yimg.com/os/creatr-uploaded-images/2021-02/eea32ae0-6bdc-11eb-bf5e-5d7f15d13ff6", width: 513, height: 100),
            Resolution(tag: "100x50", url: "https://s.yimg.com/uu/api/res/1.2/8ivOqKUcScynOSokmb5x4g--~B/Zmk9ZmlsbDtoPTUwO3B5b2ZmPTA7dz0xMDA7YXBwaWQ9eXRhY2h5b24-/https://s.yimg.com/os/creatr-uploaded-images/2021-02/eea32ae0-6bdc-11eb-bf5e-5d7f15d13ff6", width: 100, height: 50)
        ])

        // Create an instance of the Provider model
        let provider = Provider(url: url, displayName: displayName, logo: logo, lightLogo: lightLogo, darkLogo: darkLogo)
        
        // Return the Provider instance
        return provider
    }
}


// Dummy data for the Thumbnail model
extension Thumbnail {
    static func mock() -> Thumbnail {
        // Define values for the Thumbnail model
        let originalUrl = "https://s.yimg.com/os/creatr-uploaded-images/2024-04/e62ecf80-fe6a-11ee-bf5e-5b9119753b75"
        let originalWidth = 5378
        let originalHeight = 3586
        let resolutions = [
            Resolution(tag: "original", url: "https://s.yimg.com/os/creatr-uploaded-images/2024-04/e62ecf80-fe6a-11ee-bf5e-5b9119753b75", width: 5378, height: 3586),
            Resolution(tag: "150x150", url: "https://s.yimg.com/os/creatr-uploaded-images/2024-04/e62ecf80-fe6a-11ee-bf5e-5b9119753b75",  width: 150, height: 150)
        ]
        
        // Create an instance of the Thumbnail model
        let thumbnail = Thumbnail(originalUrl: originalUrl, originalWidth: originalWidth, originalHeight: originalHeight, resolutions: resolutions)
        
        // Return the Thumbnail instance
        return thumbnail
    }
}
