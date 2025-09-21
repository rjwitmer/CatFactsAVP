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

            List(catVM.breeds, id: \.id) { catBreed in
                Text(catBreed.breed)
            }
            .navigationTitle(Text("Cat Breeds:"))
        }
        .task {
            await catVM.getData()
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ListView()
}
