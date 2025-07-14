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
    
    enum fetchError: Error {
        case badResponse
    }
    
    let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    
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
    
  
}

