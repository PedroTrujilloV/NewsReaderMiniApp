//
//  ContentView.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/19/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let viewModel: NewsStreamViewModel

    var body: some View {
        NewsStreamView(viewModel: viewModel)
    }
} 


struct ContentView_Previews: PreviewProvider {
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
        ContentView(viewModel: viewModel)
    }
}
