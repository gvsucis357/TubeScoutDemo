//
//  YTHelper.swift
//  TubeScoutDemo
//
//  Created by Jonathan Engelsma on 4/9/25.
//
import SwiftUI

func searchVideos(query: String, viewModel: YouTubeSearchViewModel) async {
    
    let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

    let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(queryEncoded)&type=video&maxResults=20&key=\(apiKey)"
    
    guard let url = URL(string: urlString) else { return }

    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let result = try JSONDecoder().decode(YouTubeSearchResponse.self, from: data)

        
        await MainActor.run {
            viewModel.videos = result.items.compactMap { item in
                if let videoId = item.id.videoId {
                    return Video(
                        id: videoId,
                        title: item.snippet.title,
                        thumbnailURL: item.snippet.thumbnails.medium.url
                    )
                }
                return nil
            }
        }

        
    } catch {
        print("Failed to fetch or decode videos: (error)")
    }

    
}
