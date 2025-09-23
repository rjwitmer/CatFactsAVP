//
//  Fact.swift
//  CatFactsAVP
//
//  Created by Bob Witmer on 2025-09-23.
//

import Foundation

struct Fact: Codable, Identifiable {
    let id: String = UUID().uuidString  // Unique ID for each fact
    var fact: String
    var length: Int
    
    init(fact: String = "", length: Int = 0) {
        self.fact = fact
        self.length = length
    }
    
    enum CodingKeys: String, CodingKey {
        case fact
        case length
    }
}
