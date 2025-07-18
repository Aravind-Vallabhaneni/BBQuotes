//
//  FetchService.swift
//  BBQuotes
//
//  Created by Aravind vallabhaneni on 14/07/25.
//


import Foundation

// Basics of Fetching data from an API
// Step 1: Build the URL.
// Step 2: Fetch the data (Hitting the API and retriving response from it).
// Step 3: Handling Response (As, we hitting an API, we would receive a response code, so we have to decode the data based upon that code).
// Step 4: If the request succeed, then we will decode the response data.

struct FetchService {
    
   private enum fetchError: Error {
        case badResponse
    }
    
   private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    
    func fetchQuote(from show: String) async throws -> Quote {
        
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        let (data,responseCode) = try await URLSession.shared.data(from: fetchURL)
        
        guard let responseCode = responseCode as? HTTPURLResponse, responseCode.statusCode == 200 else {
            throw fetchError.badResponse
        }
        
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        return quote
    }
    
    func fetchCharacter(_ name: String) async throws -> Char {
        
        let characterURL = baseURL.appending(path: "characters")
        let fetchURL = characterURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        let (data,responseCode) = try await URLSession.shared.data(from: fetchURL)
        
        guard let responseCode = responseCode as? HTTPURLResponse, responseCode.statusCode == 200 else {
            throw fetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Char].self, from: data)
        
        return characters[0]
    }
    
    
    func fetchDeath(for character: String) async throws -> Death? {
        
        let fetchURL = baseURL.appending(path: "deaths")
        
        let (data,responseCode) = try await URLSession.shared.data(from: fetchURL)
        
        guard let responseCode = responseCode as? HTTPURLResponse, responseCode.statusCode == 200 else {
            throw fetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([Death].self, from: data)

        for death in deaths {
            if death.character == character{
                return death
            }
        }
        
        return nil
    }
    
    func fetchEpisode(for show: String) async throws -> Episode? {
        
        let fetchURL = baseURL.appending(path: "episodes")
        let episodeURL = fetchURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        let (data,response) = try await URLSession.shared.data(from: episodeURL)
        
        guard let responseCode = response as? HTTPURLResponse, responseCode.statusCode == 200 else {
            throw fetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let episode = try decoder.decode([Episode].self, from: data)
        
        return episode.randomElement()
    }
  
}

