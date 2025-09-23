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
    @State var catVM: CatViewModel = CatViewModel()
    @State var factVM: FactViewModel = FactViewModel()
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
                        if catVM.nextPageURL.hasPrefix("http") {
                            catVM.urlString = catVM.nextPageURL
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
                FactView(fact: Fact(fact: factVM.facts.randomElement()!.fact, length: 1))
            }
            
        }
        .task {
            await catVM.getData()
            await factVM.getData()
            await factVM.loadAll()
            print("\(factVM.total)")
            
        }
    }
}

#Preview(windowStyle: .automatic) {
    ListView()
}
