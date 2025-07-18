//
//  EpisodeView.swift
//  BBQuotes
//
//  Created by Aravind vallabhaneni on 18/07/25.
//

import SwiftUI

struct EpisodeView: View {
    
    var episode: Episode
    var body: some View {
        VStack(alignment: .leading){
            Text(episode.title)
                .font(.largeTitle)
            
            Text(episode.seasonEpisode)
                .font(.title2)
            
            AsyncImage(url: episode.image) { image in
                
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 15))
                
            } placeholder: {
                ProgressView()
            }
            
            Text(episode.synopsis)
                .font(.title3)
                .minimumScaleFactor(0.5)
                .padding(.bottom)
            
            Text("Written by: \(episode.writtenBy)")
            Text("Directed by: \(episode.directedBy)")
            Text("Aired: \(episode.airDate)")
        }
        .padding()
        .foregroundStyle(.white)
        .background(.black.opacity(0.6))
        .clipShape(.rect(cornerRadius: 25))
        .padding(.horizontal)
    }
}

#Preview {
    EpisodeView(episode: ViewModel().episode)
}
