//
//  DetailView.swift
//  CatFactsAVP
//
//  Created by Bob Witmer on 2025-09-21.
//

import SwiftUI

struct DetailView: View {
    let catBreed: CatBreed
    @State private var imageURL: String = ""

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
                
                HStack {
                    Spacer()
                    breedImage
                    Spacer()
                }

            }
            .formStyle(.automatic)
            .font(.title2)
            .navigationTitle(catBreed.breed)
        }
    }
}

extension DetailView {
    var breedImage: some View {
        AsyncImage(url: URL(string: String(ImageURL.breedImages[catBreed.breed] ?? ""))) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .white, radius: 8, x: 5, y: 5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white.opacity(0.5), lineWidth: 1)
                    }
        } placeholder: {
            Image(systemName: "rectangle.slash")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: .white, radius: 8, x: 5, y: 5)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.white.opacity(0.5), lineWidth: 1)
                }
            Text("Image not available")
        }
        .frame(height: 300)
    }
    
}

#Preview {
    DetailView(catBreed: CatBreed(breed: "Burmese", country: "Burma & Thailand", origin: "Natural", coat: "Short", pattern: "Solid"))
}
