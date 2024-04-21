//
//  YahooNewsReaderMiniAppApp.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/19/24.
//

import SwiftUI
import CoreData


@main
struct YahooNewsReaderMiniAppApp: App {

    var body: some Scene {
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
        
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
