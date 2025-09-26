//
//  ListView.swift
//  CatFactsAVP
//
//  Created by Bob Witmer on 2025-09-20.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ListView: View {
    @State private var catVM: CatViewModel = CatViewModel()
    @State private var factVM: FactViewModel = FactViewModel()
    @State private var factSheetIsShown: Bool = false
    @State private var randomFact: String = ""
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                List(catVM.breeds, id: \.id) { catBreed in
                    LazyVStack {
                        NavigationLink(destination: DetailView(catBreed: catBreed)) {
                            Text(catBreed.breed)
                        }
                    }
                    .task {
                        if catVM.urlString.hasPrefix("http") {
                            await catVM.getNextPage(catBreed: catBreed)
                        }
                    }
                }
                .navigationTitle(Text("Cat Breeds:"))
                .toolbar {
                    ToolbarItem(placement: .status) {
                        Text("\(catVM.breeds.count) of \(catVM.total) breeds loaded")
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            factSheetIsShown.toggle()
                        } label: {
                            Text("🐈‍⬛💡")
                        }
                        
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button("Load All Breeds") {
                            Task {
                                await catVM.loadAll()
                            }
                        }
                    }
                    
                }
                
                if catVM.isLoading {
                    ProgressView()
                        .tint(Color.blue)
                        .scaleEffect(4.0)
                }
            }
            .sheet(isPresented: $factSheetIsShown) {
                FactView()
            }
            
        }
        .task {
            await catVM.getData()
        }
    }
}

#Preview(windowStyle: .automatic) {
    ListView()
}
