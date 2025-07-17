//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Aravind vallabhaneni on 17/07/25.
//

import SwiftUI

struct QuoteView: View {
    
    var viewM = ViewModel()
    var show: String
    @State var showCharacterInfo: Bool = false
    
    var body: some View {
        
        GeometryReader {
            geo in
            
            ZStack{
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
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
                            
                        case .success:
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
                            
                        case .failed(let error):
                            Text(error.localizedDescription)
                        }
                        
                        
                        Spacer()
                    }
                    
                    Button {
                        Task {
                            await viewM.fethData(for: show)
                        }
                    } label: {
                        Text("Get Random Quote")
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color("\(show.replacingOccurrences(of: " ", with: ""))Button"))
                            .clipShape(.rect(cornerRadius: 15))
                            .shadow(color: Color("\(show.replacingOccurrences(of: " ", with: ""))Shadow"), radius: 2)
                            
                    }
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
    QuoteView(show: "Breaking Bad")
}
