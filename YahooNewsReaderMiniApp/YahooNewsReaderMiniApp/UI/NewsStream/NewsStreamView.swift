//
//  NewsStreamView.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/19/24.
//

import SwiftUI


struct NewsStreamView: View {
    @ObservedObject var viewModel: NewsStreamViewModel
    @State private var selectedArticle: ArticleViewModel? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.articleViewModels, id: \.id) { articleViewModel in

                    NavigationLink {
                        ArticleDetailView(articleViewModel: articleViewModel)
                    } label: {
                        ArticleView(viewModel: articleViewModel)
                            .onAppear {
                                if articleViewModel == viewModel.articleViewModels.last {
                                    viewModel.reachScrollLimit()
                                }
                            }
                    }
                }
                if viewModel.isLoadingNextPage {
                    ProgressView()
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
            .navigationTitle("News Stream")
        }
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


