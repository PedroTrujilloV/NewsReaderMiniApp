//
//  NewsStreamView.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/19/24.
//

import SwiftUI


struct NewsStreamView: View {
    @ObservedObject var viewModel: NewsStreamViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.articleViewModels, id: \.id) { articleViewModel in
                ArticleView(viewModel: articleViewModel)
            }
            if viewModel.isLoadingNextPage {
                ProgressView() // Show a loading indicator when fetching the next page
            }
        }
        .refreshable {
            // Handle pull-to-refresh action here
            if viewModel.isRefreshing == false {
                viewModel.refresh()
            }
        }
        .onAppear {
            // Load initial data
            viewModel.loadInitialData()
        }
        .padding( .horizontal, -20)
    }
}

struct NewsStreamView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = NewsStreamViewModel()
        //viewModel.mock()
        NewsStreamView(viewModel: viewModel)
    }
}


