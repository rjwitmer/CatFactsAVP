//
//  FactViewModel.swift
//  CatFactsAVP
//
//  Created by Bob Witmer on 2025-09-23.
//

import Foundation

@Observable
class FactViewModel {
    private struct Returned: Codable {
        var fact: String
    }
    
    var urlString: String = "https://catfact.ninja/fact"
    var fact: String = ""
    var isLoading: Bool = false
    
    func getData() async {
        print("🕸️ We are accessing url: \(urlString)")
        isLoading = true
        
        // Create a URL
        guard let url = URL(string: urlString) else {
            print( "😡 Error: Cannot create URL \(urlString)")
            isLoading = false
            
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url) // 'response' is not used in this app
            
            // Try to decode the JSON data into our own data structures
            guard let decodedData = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("😡 JSON Error: Could not decode JSON data")
                isLoading = false
                return
            }
            Task { @MainActor in
                self.fact = decodedData.fact
                isLoading = false
            }
        } catch {
            print( "😡 ERROR: Could not load data from \(urlString): \(error.localizedDescription)")
            isLoading = false
        }
    }
}
