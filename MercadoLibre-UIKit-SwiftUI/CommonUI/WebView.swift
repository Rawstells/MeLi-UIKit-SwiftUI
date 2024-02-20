//
//  WebView.swift
//  MercadoLibre-UIKit-SwiftUI
//
//  Created by Joan Narvaez on 20/02/24.
//

import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: URL(string: url)!))
    }
}
