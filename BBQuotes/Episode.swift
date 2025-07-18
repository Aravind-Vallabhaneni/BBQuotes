//
//  Episode.swift
//  BBQuotes
//
//  Created by Aravind vallabhaneni on 18/07/25.
//

import Foundation

struct Episode: Decodable {
    
    let episode: Int
    let title: String
    let writtenBy: String
    let directedBy: String
    let airDate: String
    let synopsis: String
    let image: URL
    
    var seasonEpisode: String {
        "Season \(episode/100) Episode \(episode%100)"
    }
}
