//
//  NewsStreamView.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/19/24.
//

import SwiftUI
import CoreData

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
                    .listRowSeparator(.hidden)
                }
                if viewModel.isLoadingNextPage {
                    ProgressView()
                }
            }
            .padding( .horizontal, -20)
            .refreshable {
                if viewModel.isRefreshing == false {
                    viewModel.refresh()
                }
            }
            .onAppear {
                viewModel.refresh()
            }
            .navigationTitle("News Stream")
            
        }
    }
}

struct NewsStreamView_Previews: PreviewProvider {
    static var previews: some View {
        let scheduler: DispatchQueue =  .main
        let persistentContainer: NSPersistentContainer = {
             let container = NSPersistentContainer(name: "NewsStreamModel")
             container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                 if let error = error {
                     fatalError("Failed to load persistent stores: \(error)")
                 }
             })
             return container
         }()
        let repository = NewsStreamRepositoryImplementation(apiService: APIServiceImplementation(),
                                                            scheduler: scheduler,
                                                            persistentContainer: persistentContainer)
        
        let newsStreamService = NewsStreamServiceImplementation(repository: repository)
        let viewModel = NewsStreamViewModel( newsStreamService: newsStreamService,
                                             isLoadingNextPage: repository.isLoadingNextPage ,
                                            scheduler: scheduler)
        //let _ = viewModel.mock()
        NewsStreamView(viewModel: viewModel)
        
    }
}




