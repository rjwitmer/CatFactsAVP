//
//  FactView.swift
//  CatFactsAVP
//
//  Created by Bob Witmer on 2025-09-23.
//

import SwiftUI

struct FactView: View {
    @Environment(\.dismiss) var dismiss
    let fact: Fact
    var body: some View {
        NavigationStack {
            Text("🐈  Cat Fact:")
                .font(.largeTitle)
                .bold()
                .padding(.bottom)
            Text(fact.fact)
                .font(.title2)
            Button("Dismiss") {
                dismiss()
            }
            .tint(Color(.systemBlue))
                
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    FactView(fact: Fact(fact: "Cat Fact Here", length: 0))
}
