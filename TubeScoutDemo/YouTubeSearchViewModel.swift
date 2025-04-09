//
//  YouTubeSearchViewModel.swift
//  TubeScoutDemo
//
//  Created by Jonathan Engelsma on 4/9/25.
//
import SwiftUI

struct YouTubeSearchResponse: Codable {
    struct Item: Codable {
        struct ID: Codable {
            let videoId: String?
        }
        struct Snippet: Codable {
            let title: String
            let thumbnails: Thumbnails
        }
        struct Thumbnails: Codable {
            struct Default: Codable {
                let url: String
            }
            let medium: Default
        }
        let id: ID
        let snippet: Snippet
    }
    let items: [Item]
}

struct Video: Identifiable, Codable {
    let id: String
    let title: String
    let thumbnailURL: String
}

class YouTubeSearchViewModel: ObservableObject {
    @Published var videos: [Video] = []
}

