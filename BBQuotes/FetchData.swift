//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Aravind vallabhaneni on 17/07/25.
//

import SwiftUI

struct FetchData: View {
    
    var viewM = ViewModel()
    var show: String
    @State var showCharacterInfo: Bool = false
    
    var body: some View {
        
        GeometryReader {
            geo in
            
            ZStack{
                Image(show.removeSpaceandCase())
                    .resizable()
                    .frame(width: geo.size.width*2.7, height: geo.size.height * 1.2 )
                
                VStack {
                    
                    VStack {
                        Spacer(minLength: 60)
                        
                        switch viewM.status {
                            
                        case .notStarted:
                            EmptyView()
                            
                        case .fetching:
                            ProgressView()
                            
                        case .successQuote:
                            Text("\"\(viewM.quote.quote)\"")
                                .minimumScaleFactor(0.5)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            
                            ZStack(alignment: .bottom) {
                                
                                AsyncImage(url: viewM.character.images[0]) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width:geo.size.width/1.1,height: geo.size.height/1.8)
                                
                                Text(viewM.quote.character)
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(.black.opacity(0.5 ))
                                
                            }
                            .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                            .clipShape(.rect(cornerRadius: 50))
                            .onTapGesture{
                                showCharacterInfo.toggle()
                            }
                            
                        case .sucessEpisode:
                            EpisodeView(episode: viewM.episode)
                            
                        case .failed(let error):
                            Text(error.localizedDescription)
                        }
                        
                        
                        Spacer(minLength: 20)
                    }
                    
                    HStack{
                        Button {
                            Task {
                                await viewM.fetchQuoteData(for: show)
                            }
                        } label: {
                            Text("Get Random Quote")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color("\(show.removeSpaces())Button"))
                                .clipShape(.rect(cornerRadius: 15))
                                .shadow(color: Color("\(show.removeSpaces())Shadow"), radius: 2)
                            
                        }
                        
                        Spacer()
                        
                        Button {
                            Task {
                                await viewM.fetchEpisode(for: show)
                            }
                        } label: {
                            Text("Get Random Episode")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color("\(show.removeSpaces())Button"))
                                .clipShape(.rect(cornerRadius: 15))
                                .shadow(color: Color("\(show.removeSpaces())Shadow"), radius: 2)
                            
                        }
                    }
                    .padding(.horizontal, 30)
                    Spacer(minLength: 95)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showCharacterInfo) {
            Characterview(character: viewM.character, show: show)
        }
    }
}

#Preview {
    FetchData(show: Constants.bbName)
}
