//
//  ContentView.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/19/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        let scheduler: DispatchQueue =  .main
        let repository = NewsStreamRepositoryImplementation(apiService: APIServiceImplementation(),
                                                            scheduler: scheduler)
        let newsStreamService = NewsStreamServiceImplementation(repository: repository)
        let viewModel = NewsStreamViewModel( newsStreamService: newsStreamService, 
                                             isLoadingNextPage: repository.isLoadingNextPage ,
                                            scheduler: scheduler)
        
        NewsStreamView(viewModel: viewModel)
            .padding( .horizontal,   -20)
    }
} 

#Preview {
    ContentView()
}
