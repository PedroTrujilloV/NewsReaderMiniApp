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
                    .onAppear {
                        if articleViewModel == viewModel.articleViewModels.last { // Detect if the last item is about to appear
                            viewModel.reachScrollLimit() // Call method in view model
                        }
                    }
            }
            if viewModel.isLoadingNextPage {
                ProgressView() // Show a loading indicator when fetching the next page
            }
        }
        .refreshable {
            if viewModel.isRefreshing == false {
                viewModel.refresh()
            }
        }
        .onAppear {
            viewModel.refresh()
        }
        .padding( .horizontal, -20)
    }
}

struct NewsStreamView_Previews: PreviewProvider {
    static var previews: some View {
        let scheduler: DispatchQueue =  .main
        let repository = NewsStreamRepositoryImplementation(apiService: APIServiceImplementation(),
                                                            scheduler: scheduler)
        let newsStreamService = NewsStreamServiceImplementation(repository: repository)
        let viewModel = NewsStreamViewModel( newsStreamService: newsStreamService,
                                             isLoadingNextPage: repository.isLoadingNextPage ,
                                            scheduler: scheduler)
        
        NewsStreamView(viewModel: viewModel)
    }
}


