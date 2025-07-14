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
}


