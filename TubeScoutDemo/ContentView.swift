//
//  ContentView.swift
//  TubeScoutDemo
//
//  Created by Jonathan Engelsma on 4/9/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = YouTubeSearchViewModel()
    @State private var searchQuery = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search YouTube", text: $searchQuery, onCommit: {
                    Task {
                        await searchVideos(query: searchQuery, viewModel: viewModel)
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                List(viewModel.videos) { video in
                    NavigationLink(destination: VideoPlayerView(videoId: video.id)) {
                        HStack {
                            AsyncImage(url: URL(string: video.thumbnailURL)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 60)
                            .cornerRadius(8)
                            
                            Text(video.title)
                                .font(.headline)
                                .lineLimit(2)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Tube Scout!")
        }
    }
}

#Preview {
    ContentView()
}
