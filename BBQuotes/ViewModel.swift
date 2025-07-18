//
//  ViewModel.swift
//  BBQuotes
//
//  Created by Aravind vallabhaneni on 15/07/25.
//

import Foundation

@Observable
@MainActor
class ViewModel {
    
    enum fetchStatus{
        
        case notStarted
        case fetching
        case successQuote
        case sucessEpisode
        case failed(error: Error)
        
    }
    
    private(set) var status = fetchStatus.notStarted
    
    private let fetcher = FetchService()
    
    var quote: Quote
    var character: Char
    var episode: Episode
    
    init() {
        
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        character = try! decoder.decode(Char.self, from: characterData)
        
        let episodeData = try! Data(contentsOf: Bundle.main.url(forResource: "sampleepisode", withExtension: "json")!)
        episode = try! decoder.decode(Episode.self, from: episodeData)
    }
    
    func fetchQuoteData(for show: String) async {
        
        status = .fetching
        
        do {
            
            quote = try await fetcher.fetchQuote(from: show)
            
            character = try await fetcher.fetchCharacter(quote.character)
            
            character.death = try await fetcher.fetchDeath(for: character.name)
            
            status = .successQuote
            
        } catch {
            
            status = .failed(error: error)
        }
        
    }
    
    
    func fetchEpisode(for show: String) async {
        
        status = .fetching
        
        do {
            
            if let episodeData = try await fetcher.fetchEpisode(for: show) {
                episode = episodeData
                
            }
            
            status = .sucessEpisode
            
        } catch {
            status = .failed(error: error)
        }
    }
}
