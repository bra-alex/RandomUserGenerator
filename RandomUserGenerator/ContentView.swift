//
//  ContentView.swift
//  RandomUserGenerator
//
//  Created by Don Bouncy on 01/03/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var ruc = RandomUserController()
    var body: some View {
        NavigationStack {
            VStack {
                if let user = ruc.user{
                    VStack{
                        AsyncImage(url: URL(string: user.picture.large)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                        .padding(.bottom)
                        
                        Text("Registered \(user.registered.date.formatted(date: .abbreviated, time: .omitted))")
                            .font(.subheadline)
                    }
                    Spacer()
                    
                    GeometryReader { proxy in
                        let width = proxy.frame(in: .global).width
                        VStack {
                            VStack {
                                HStack {
                                    Text("Name")
                                    Spacer()
                                    Text(user.name.fullName)
                                }
                                Divider()
                            }
                            .padding()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white)
                                .padding()
                                .shadow(color: .black.opacity(0.1), radius: 8, x: -8, y: 8)
                            
                        )
                        .padding()
                    }
                    
                } else {
                    ProgressView()
                }
            }
            .task {
                await ruc.loadData()
            }
            .toolbar {
                Button {
                    Task {
                        await ruc.loadData()
                    }
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.black)
                        .padding(7)
                        .padding(.trailing, 5)
                }
                .background {
                    Color.white
                }
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: .black.opacity(0.1), radius: 8, x: -8, y: 8)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
