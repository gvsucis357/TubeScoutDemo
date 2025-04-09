//
//  VideoPlayerView.swift
//  TubeScoutDemo
//
//  Created by Jonathan Engelsma on 4/9/25.
//

import SwiftUI
import WebKit

struct VideoPlayerView: View {
    let videoId: String
    
    var body: some View {
        WebView(url: URL(string: "https://www.youtube.com/embed/\(videoId)")!)
            .edgesIgnoringSafeArea(.all)
    }
}

struct WebView: UIViewRepresentable {
    // Explicitly declare the associated type
    typealias UIViewType = WKWebView
    
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }

}

