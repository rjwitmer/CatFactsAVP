//
//  CatBreed.swift
//  CatFactsAVP
//
//  Created by Bob Witmer on 2025-09-21.
//

import Foundation

@Observable
class CatViewModel {
    private struct Returned: Codable {
        var total: Int
        var data: [CatBreed]
        var next_page_url: String?
    }
    
    var urlString: String = "https://catfact.ninja/breeds"
    var total: Int = 0
    var breeds: [CatBreed] = []
    var nextPageURL: String = ""
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
                self.total = decodedData.total
                self.breeds = self.breeds + decodedData.data
                self.nextPageURL = decodedData.next_page_url ?? ""
                isLoading = false
            }
        } catch {
            print( "😡 ERROR: Could not load data from \(urlString): \(error.localizedDescription)")
            isLoading = false
        }
    }
    
    func getNextPage(catBreed: CatBreed) async {
        guard let lastBreedName = breeds.last else {
            return
        }
        if catBreed.id == lastBreedName.id && !nextPageURL.isEmpty {
            await getData()
        }
    }
    
    func loadAll() async {
        Task { @MainActor in
            guard urlString.hasPrefix("http") else {return}
            urlString = nextPageURL
            await getData() // Get Next Page of data
            await loadAll() // Recursive call until nextPageURL is null
        }
    }
}
