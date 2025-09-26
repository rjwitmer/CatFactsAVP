//
//  FactView.swift
//  CatFactsAVP
//
//  Created by Bob Witmer on 2025-09-23.
//

import SwiftUI

struct FactView: View {
    @Environment(\.dismiss) var dismiss
    @State private var factVM: FactViewModel = FactViewModel()

    var body: some View {
        VStack {
            Text("🐈  Cat Fact:")
                .font(.system(size: 42))
                .bold()

            Text(factVM.fact)
                .font(.title2)
                .multilineTextAlignment(.center)
            Button("Dismiss") {
                dismiss()
            }
            .tint(Color(.systemBlue))
                
        }
        .padding()
        .navigationBarBackButtonHidden()
        .presentationDetents([.medium])
        .task {
            await factVM.getData()
        }
    }
}

#Preview {
    FactView()
}
