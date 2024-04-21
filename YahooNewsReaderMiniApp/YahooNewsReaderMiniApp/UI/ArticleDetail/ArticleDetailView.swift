//
//  ArticleDetailView.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/20/24.
//

import SwiftUI
import WebKit

struct ArticleDetailView: View {
    let articleViewModel: ArticleViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Text(articleViewModel.title)
                    .font(.title)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                Text(articleViewModel.publishedDateString)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HTMLStringView(htmlString: articleViewModel.markup)
                    .frame(minWidth: UIScreen.main.bounds.width * 0.96, maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.98, maxHeight: .infinity)
                    .padding()
            }
            .padding()
        }
       
    }
}

#Preview {
    ArticleDetailView(articleViewModel: ArticleViewModel(article: Article.mock() ) )
}
