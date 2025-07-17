//
//  char.swift
//  BBQuotes
//
//  Created by Aravind vallabhaneni on 14/07/25.
//

import Foundation

struct Char: Decodable {
    
    let name: String
    let birthday: String
    let occupations: [String]
    let aliases: [String]
    let images: [URL]
    let status: String
    let portrayedBy: String
    
    var death: Death?
    
    enum CodingKeys: CodingKey {
        case name
        case birthday
        case occupations
        case aliases
        case images
        case status
        case portrayedBy
       
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.birthday = try container.decode(String.self, forKey: .birthday)
        self.occupations = try container.decode([String].self, forKey: .occupations)
        self.aliases = try container.decode([String].self, forKey: .aliases)
        self.images = try container.decode([URL].self, forKey: .images)
        self.status = try container.decode(String.self, forKey: .status)
        self.portrayedBy = try container.decode(String.self, forKey: .portrayedBy)
        
        
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deathData = try! Data(contentsOf: Bundle.main.url(forResource: "sampledeath", withExtension: "json")!)
        death = try! decoder.decode(Death.self, from: deathData)
    }
}


