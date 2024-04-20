//
//  ArticleView.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/19/24.
//

import SwiftUI

struct ArticleView: View {
    @ObservedObject var viewModel: ArticleViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center) {
                if let thumbnailURL = viewModel.thumbnailURL {
                    AsyncImage(url: thumbnailURL)
                        .frame(width: UIScreen.main.bounds.width * 0.4, height: viewModel.resolution.height)
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(8)
                        .clipped()
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.provider)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(viewModel.title)
                        .font(.headline)
                    Text(viewModel.subheadline)
                        .font(.subheadline)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.94, height: .maximum( UIScreen.main.bounds.height * 0.22, viewModel.resolution.height))
        .padding(8)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ArticleViewModel(article: Article.mock())
        ArticleView(viewModel: viewModel)
    }
}

