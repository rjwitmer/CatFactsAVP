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

    var body: some View {
        NavigationStack {

            ZStack {
                List(catVM.breeds, id: \.id) { catBreed in
                    NavigationLink(destination: DetailView(catBreed: catBreed)) {
                        Text(catBreed.breed)
                    }
                }
                .navigationTitle(Text("Cat Breeds:"))
                
                if catVM.isLoading {
                    ProgressView()
                        .tint(Color.blue)
                        .scaleEffect(4.0)
                }
            }
        }
        .task {
            await catVM.getData()
            await catVM.loadAll()

        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ListView()
}
