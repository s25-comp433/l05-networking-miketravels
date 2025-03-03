//
//  ContentView.swift
//  BasketballGames
//
//  Created by Samuel Shi on 2/27/25.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var id: Int
    var team: String
    var isHomeGame: Bool
    var score: [String]
    var date: String
    var opponent: String
}

struct ContentView: View {
    @State private var results = [Result]()
    
    var body: some View {
        VStack(alignment: .center){
            Text("UNC Basketball")
            List($results, id: \.id) { item in
                VStack(alignment: .leading) {
                    HStack(){
                        VStack(){
                            Text("\(item.team) vs. \(item.opponent)")
                                .font(.headline)
                            Text(item.date)
                                .font(.caption)
                        }
                        
                        Spacer()
                        
                        VStack(){
                            Text("\(item.score[0]) - \(item.score[1])")
                                .font(.headline)
                            if item.isHomeGame {
                                Text("Home")
                                    .font(.caption)
                            } else {
                                Text("Away")
                                    .font(.caption)
                            }
                        }
                    }
                    
                    
                    
                }
            }
            .task{
                await loadData()
            }
        }
        
    }
    
    func loadData() async {
        guard let url = URL(string: "https://api.samuelshi.com/uncbasketball") else {
            print("Invalid URL")
            return
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
}

