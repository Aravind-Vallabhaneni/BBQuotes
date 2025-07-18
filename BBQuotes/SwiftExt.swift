//
//  SwiftExt.swift
//  BBQuotes
//
//  Created by Aravind vallabhaneni on 18/07/25.
//

extension String {
    
    func removeSpaces() -> String {
        self.replacingOccurrences(of: " ", with: "")
    }
    
    func removeSpaceandCase() -> String {
        self.removeSpaces().lowercased()
    }
}
