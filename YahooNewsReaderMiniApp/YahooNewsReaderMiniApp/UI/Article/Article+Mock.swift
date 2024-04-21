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
        let body: Body? = Body(modules: [:], 
                               data: nil,
                               markup: htmlContent)
        
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

let htmlContent = """
<!DOCTYPE html><html lang=en><head><meta charset=utf-8><meta name=viewport content=\"width=device-width, minimum-scale=1.0, initial-scale=1.0, user-scalable=no\"><link rel=preconnect href=https://s.yimg.com><link rel=preconnect href=https://geo.query.yahoo.com><link rel=preconnect href=https://csc.beap.bc.yahoo.com><link rel=preconnect href=https://beap.gemini.yahoo.com><link rel=preconnect href=https://yep.video.yahoo.com><link rel=preconnect href=https://video-api.yql.yahoo.com><link rel=preconnect href=https://yrtas.btrll.com><link rel=preconnect href=https://shim.btrll.com><link href=https://s.yimg.com/aaq/c/987679d.caas-sports_app_android.min.css rel=stylesheet type=text/css><meta http-equiv=x-dns-prefetch-control content=on></head><body class=\"_CAAS_SYSTEM_THEME_OFF_PLACEHOLDER_ _CAAS_THEME_PLACEHOLDER_\"><div id=caas-articles-container class=caas-wrapper><div class=\"caas caas-cc ncp sports caas-ynet\" data-device=smartphone data-i18n='{\"{date} at {time}\":\"{date} at {time}\",\"{0} hr ago\":\"{0} hr ago\",\"{0} min ago\":\"{0} min ago\",\"{0} mins ago\":\"{0} mins ago\",\"{0} Views\":\"{0} Views\",\"INLINE_CONSENT_BLOCKED_3P_BUTTON_ALLOW\":\"Allow\",\"LESS\":\"Less\",\"LIVE_IS_OVER\":\"LIVE COVERAGE IS OVER\",\"LOADING\":\"Loading\",\"MORE\":\"More\",\"NEW_UPDATE\":\"new update\",\"NEW_UPDATES\":\"new updates\",\"JUST_NOW\":\"Just now\",\"RELOAD\":\"Click to reload with latest update\",\"SEE {0} MORE\":\"See {0} more\",\"SEE_LESS\":\"See less\",\"SEE_MORE\":\"See more\",\"SHOW_MORE\":\"Show more updates\",\"TODAY\":\"Today\",\"TRY_AGAIN\":\"Something went wrong. Try again\",\"UPDATE\":\"update\",\"UPDATES\":\"updates\",\"VIDEO_A11Y_DISABLE_FULLSCREEN\":\"Full Screen, button, disabled, temporarily not available for screen reader users\"}' data-lang=en-US data-tz=America/New_York data-params='{\"features\":{\"ncp\":true},\"config\":{\"authorBylineCollapseLineCount\":2,\"commerceQuickOverviewLimit\":5,\"freezeOnLinkClick\":false,\"lazyOffsetY\":900,\"livecoverage\":{\"defer\":false},\"imageCaptionCollapseLineCount\":3,\"slideshowCaptionCollapseLineCount\":2,\"uiShowPreviousButtonOnLoad\":false,\"prestigeScrollMarginTop\":-72}}' id=caas-art-a6560de5-dea1-4f73-93ff-7f2708c3c235><article role=article tabindex=-1><script class=caas-yvideo-config type=application/ld+json>\
        {}\
    </script><script class=caas-timezone-config type=application/ld+json>\
        {\"longForm\":{\"weekday\":\"short\",\"day\":\"numeric\",\"hour\":\"numeric\",\"hourCycle\":\"h12\",\"minute\":\"2-digit\",\"month\":\"long\",\"year\":\"numeric\",\"timeZoneName\":\"short\"},\"shortForm\":{\"day\":\"numeric\",\"month\":\"long\",\"year\":\"numeric\"},\"postDateLongForm\":{\"weekday\":\"short\",\"day\":\"numeric\",\"hour\":\"numeric\",\"hourCycle\":\"h12\",\"minute\":\"2-digit\",\"month\":\"long\",\"year\":\"numeric\",\"timeZoneName\":\"short\"},\"postDateShortForm\":{\"hour\":\"numeric\",\"hourCycle\":\"h12\",\"minute\":\"2-digit\",\"timeZoneName\":\"short\"}}\
    </script><script class=caas-embedded-config type=application/ld+json>\
        {\"twitter\":{\"timeout\":5000}}\
    </script><div class=caas-body><p>Jaromír Jágr took the ice on Thursday for the first time since turning 52 years old and passed Hall of Famer Gordie Howe as the oldest professional hockey player.</p><p>Playing for Rytíři Kladno, <a data-i13n=\"cpos:1;pos:1\" href=\"https://news.yahoo.com/penguins-retire-jersey-jagr-52-110217396.html?webview=1\" data-ylk=\"slk:the Czech team he owns;cpos:1;pos:1;elm:context_link;itc:0;sec:content-canvas;outcm:mb_qualified_link;_E:mb_qualified_link;ct:story;\" class=\"link rapid-noclick-resp yahoo-link\">the Czech team he owns</a> and operates, Jágr scored during a 7-2 win over VHK Vsetín in Game 2 of their playoff relegation series.</p><div class=caas-da><div id=defaultLREC><div class=caas-da-loader><i></i></div></div></div><div class=twitter-tweet-wrapper data-embed-anchor=f9645adc-e70d-52f7-99e1-16f9b170bf29><blockquote placeholder data-theme=light class=twitter-tweet><div class=\"caas-card-loader small fixed-height\"></div><p>🤯🤯🤯<br><br>Jaromír Jágr (<a href=\"https://twitter.com/jj68jaromirjagr?ref_src=twsrc%5Etfw\" rel=\"nofollow noopener\" target=\"_blank\" data-ylk=\"slk:@jj68jaromirjagr;elm:context_link;itc:0;sec:content-canvas\" class=\"link rapid-noclick-resp\">@jj68jaromirjagr</a>) naskočil po svých 5⃣2⃣. narozeninách do prvního střídání a hned je z toho branka! 🛢️<a href=\"https://twitter.com/hashtag/baraztelh?src=hash&amp;ref_src=twsrc%5Etfw\" rel=\"nofollow noopener\" target=\"_blank\" data-ylk=\"slk:#baraztelh;elm:context_link;itc:0;sec:content-canvas\" class=\"link rapid-noclick-resp\">#baraztelh</a> | <a href=\"https://twitter.com/hashtag/TELH?src=hash&amp;ref_src=twsrc%5Etfw\" rel=\"nofollow noopener\" target=\"_blank\" data-ylk=\"slk:#TELH;elm:context_link;itc:0;sec:content-canvas\" class=\"link rapid-noclick-resp\">#TELH</a> | <a href=\"https://twitter.com/RytiriKladno?ref_src=twsrc%5Etfw\" rel=\"nofollow noopener\" target=\"_blank\" data-ylk=\"slk:@RytiriKladno;elm:context_link;itc:0;sec:content-canvas\" class=\"link rapid-noclick-resp\">@RytiriKladno</a> <a href=\"https://t.co/UXjte8uwom\" rel=\"nofollow noopener\" target=\"_blank\" data-ylk=\"slk:pic.twitter.com/UXjte8uwom;elm:context_link;itc:0;sec:content-canvas\" class=\"link rapid-noclick-resp\">pic.twitter.com/UXjte8uwom</a></p><p>— Tipsport extraliga (@telhcz) <a href=\"https://twitter.com/telhcz/status/1780994066164994196?ref_src=twsrc%5Etfw\" rel=\"nofollow noopener\" target=\"_blank\" data-ylk=\"slk:April 18, 2024;elm:context_link;itc:0;sec:content-canvas\" class=\"link rapid-noclick-resp\">April 18, 2024</a></p></blockquote></div><p>Kladno&#39;s victory gave them a 2-0 lead in the best-of-seven series.</p><p>Howe was 52 years, 11 days old when he suited up for his final NHL game in 1980. He later played one shift with the Detroit Vipers of the International Hockey League in 1997 at the age of 69, but this record is for players taking regular shifts.</p><div id=caas-article-upsell class=\"caas-placeholder-upsell caas-upsell-container wafer-fetch\" data-wf-replace=1 data-wf-state-body='{\"ctrl\":\"SubscriptionMonalixa\",\"m_id\":\"react-wafer-subscription\",\"m_mode\":\"json\",\"module\":\"monalixaRightRail\",\"config\":{\"apiVersion\":\"2\",\"pageContext\":\"[state.publisherBlobPageContext]\",\"appid\":\"1b552308-2ab7-4066-a308-65e488e6e306\",\"containerselector\":\"#sports-mobile-web-article-body\",\"placement\":\"sports-mobile-web-article-body\"}}' data-wf-retry-count=2 data-wf-timeout=5000 data-wf-trigger=viewport data-wf-trigger-offset=\"600 0\" data-wf-url=/fp_ms/_rcv/remote?m_id=react-wafer-subscription&ctrl=SubscriptionMonalixa&module=monalixaRightRail&site=sports&device=smartphone&lang=en-US&region=US&m_mode=json></div><p>Jágr, whose NHL career began with the Pittsburgh Penguins during the 1990-91 season, had not played since Feb. 10, five days before his 52nd birthday. Thursday was his 16th game of the season.</p><p>Jágr has missed time this season dealing with injuries. During his recovery, he spent time back in Pittsburgh to take part in former teammate Mario Lemieux&#39;s adult fantasy camp and had his No. 68 <a data-i13n=\"cpos:2;pos:1\" href=\"https://sports.yahoo.com/jaromir-jagr-return-pittsburgh-ends-021818440.html#:~:text=Jaromir%20Jagr&#39;s%20return%20to%20Pittsburgh,retired%20%E2%80%94%20and%20catharsis%20%2D%20Yahoo%20Sports?webview=1\" data-ylk=\"slk:retired by the franchise;cpos:2;pos:1;elm:context_link;itc:0;sec:content-canvas;outcm:mb_qualified_link;_E:mb_qualified_link;ct:story;\" class=\"link rapid-noclick-resp yahoo-link\">retired by the franchise</a>.</p><p>During Jágr&#39;s stay in Pittsburgh, a <a data-i13n=\"cpos:3;pos:1\" href=\"https://sports.yahoo.com/jaromir-jagr-bobblehead-night-postponed-as-penguins-say-shipment-was-stolen-140611132.html?webview=1\" data-ylk=\"slk:planned bobblehead night did not happen;cpos:3;pos:1;elm:context_link;itc:0;sec:content-canvas;outcm:mb_qualified_link;_E:mb_qualified_link;ct:story;\" class=\"link rapid-noclick-resp yahoo-link\">planned bobblehead night did not happen</a> after the shipment of the giveaways was stolen during delivery.</p><p>Jágr is second all-time in NHL scoring with 1,921 points and fourth all-time in goals scored with 766. He played for nine teams during his 24-year career in North America.</p><p>Since leaving the Calgary Flames in 2018, Jágr has been back playing off and on with Kladno.</p></div></article></div></div><script src=https://cdnjs.cloudflare.com/ajax/libs/es6-promise/4.1.0/es6-promise.js></script><script>ES6Promise.polyfill()</script><script src=https://s.yimg.com/aaq/c/92556e0.caas-sports_app_android.min.js></script></body></html>
"""
