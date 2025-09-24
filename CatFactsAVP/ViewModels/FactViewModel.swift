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
        var total: Int
        var data: [Fact]
        var next_page_url: String?
    }
    
    var urlString: String = "https://catfact.ninja/facts"
    var total: Int = 0
    var facts: [Fact] = []
    var nextPageURL: String = ""
    var fact: String = ""
    var isLoading: Bool = false
    var randomIndex: Int = 0
    
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
                self.total = decodedData.total
                self.facts = self.facts + decodedData.data
                self.nextPageURL = decodedData.next_page_url ?? ""
                isLoading = false
            }
        } catch {
            print( "😡 ERROR: Could not load data from \(urlString): \(error.localizedDescription)")
            isLoading = false
        }
    }
    
    func loadAll() async {
        Task { @MainActor in
            urlString = nextPageURL
            guard urlString.hasPrefix("http") else {return}
            await getData() // Get Next Page of data
            await loadAll() // Recursive call until nextPageURL is null
        }
    }
}
