//
//  DetailView.swift
//  CatFactsAVP
//
//  Created by Bob Witmer on 2025-09-21.
//

import SwiftUI

struct DetailView: View {
    let catBreed: CatBreed

    var body: some View {
        NavigationStack {
            Form {
                HStack(spacing: 30) {
                    Text("Country:\t")
                        .fontWeight(.black)
                    Text("\(catBreed.country)")
                }
                .font(.title2)
                HStack {
                    Text("Origin:\t\t\t")
                        .fontWeight(.black)
                    Text("\(catBreed.origin)")
                }
                HStack {
                    Text("Coat:\t\t\t")
                        .fontWeight(.black)
                    Text("\(catBreed.coat)")
                }
                HStack {
                    Text("Pattern:\t\t")
                        .fontWeight(.black)
                    Text("\(catBreed.pattern)")
                }

            }
            .formStyle(.automatic)
            .font(.title2)
            .navigationTitle(catBreed.breed)
        }
    }
}

#Preview {
    DetailView(catBreed: CatBreed(breed: "Burmese", country: "Burma & Thailand", origin: "Natural", coat: "Short", pattern: "Solid"))
}
