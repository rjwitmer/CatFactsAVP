//
//  CatBreed.swift
//  CatFactsAVP
//
//  Created by Bob Witmer on 2025-09-21.
//

import Foundation

struct CatBreed: Codable, Identifiable {
    let id: String = UUID().uuidString  // unique ID for each breed
    var breed: String
    var country: String
    var origin: String
    var coat: String
    var pattern: String
    
    init(breed: String = "", country: String = "", origin: String = "", coat: String = "", pattern: String = "") {
        self.breed = breed
        self.country = country
        self.origin = origin
        self.coat = coat
        self.pattern = pattern
    }
    
    enum CodingKeys: CodingKey {
        case breed, country, origin, coat, pattern
    }
    
}
