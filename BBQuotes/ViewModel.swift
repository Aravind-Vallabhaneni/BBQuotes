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
        case success
        case failed(error: Error)
        
    }
    
    private(set) var status = fetchStatus.notStarted
    
    private let fetcher = FetchService()
    
    var quote: Quote
    var character: Char
    
    init() {
        
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        character = try! decoder.decode(Char.self, from: characterData)
    }
    
    func fethData(for show: String) async {
        
        status = .fetching
        
        do {
            
            quote = try await fetcher.fetchQuote(from: show)
            
            character = try await fetcher.fetchCharacter(quote.character)
            
            character.death = try await fetcher.fetchDeath(for: character.name)
            
        } catch {
            
            status = .failed(error: error)
        }
        
        
        
        
    }
}
