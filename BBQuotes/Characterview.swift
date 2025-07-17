//
//  Characterview.swift
//  BBQuotes
//
//  Created by Aravind vallabhaneni on 17/07/25.
//

import SwiftUI

struct Characterview: View {
    
    let character: Char
    let show: String
    
    var body: some View {
        GeometryReader{ geo in
            ZStack(alignment: .top){
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .scaledToFit()
                
                ScrollView {
                    AsyncImage(url: character.images[0]) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: geo.size.width/1.2,height: geo.size.height/1.7)
                    .clipShape(.rect(cornerRadius: 25))
                    .padding(.top,60)
                    
                    VStack(alignment: .leading) {
                        Text(character.name)
                            .font(.largeTitle)
                        
                        Text("Portrayed By: \(character.portrayedBy)")
                            .font(.subheadline)
                        
                        Divider()
                        
                        Text("\(character.name) character info")
                            .font(.title2)
                        
                        Text("born: \(character.birthday)")
                        
                        Divider()
                        
                        Text("Occupations:")
                        
                        ForEach(character.occupations, id: \.self) { occupation in
                            Text("• \(occupation)")
                                .font(.subheadline)
                        }
                        
                        Divider()
                        
                        Text("Nicknames: ")
                        
                        if character.aliases.count > 0 {
                            ForEach(character.aliases, id: \.self) { alias in
                                Text("• \(alias)")
                                    .font(.subheadline)
                            }
                        } else {
                            Text("None")
                                .font(.subheadline)
                        }
                        
                        Divider()
                        
                        DisclosureGroup("Status (spolier alert!): "){
                            VStack(alignment: .leading) {
                                Text(character.status)
                                    .font(.title2)
                                    .padding(.leading, 5)
                                
                                if let death = character.death {
                                    AsyncImage(url: death.image) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(.rect(cornerRadius: 15))
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    
                                    Text("How: \(death.details)")
                                        .padding(.bottom,7)
                                    
                                    Text("Last words: \"\(death.lastWords)\"")
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .tint(.primary)
                        
                   }
                    .frame(width: geo.size.width/1.25,alignment: .leading)
                    .padding(.bottom, 50)
                }
                .scrollIndicators(.hidden)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    Characterview(character: ViewModel().character, show: "Breaking Bad")
}
