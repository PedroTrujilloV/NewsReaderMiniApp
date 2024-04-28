//
//  HTMLStringView.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/20/24.
//

import SwiftUI
import WebKit

struct HTMLStringView: UIViewRepresentable {
    let htmlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.allowsBackForwardNavigationGestures = true
        uiView.allowsLinkPreview = true
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
}

#Preview {
    HTMLStringView(htmlString: htmlContent)
}
