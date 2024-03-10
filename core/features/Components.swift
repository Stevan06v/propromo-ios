//
//  TextFieldStyle.swift
//  Propromo
//
//  Created by Jonas Fröller on 09.03.24.
//

import Foundation
import SwiftUI
import WebKit

struct TextFieldPrimaryStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .cornerRadius(5)
            .background(Color(UIColor.systemGray6))
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color(UIColor.systemGray3), lineWidth: 1)
            )
    }
}

struct WebView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    let svgString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.loadHTMLString(svgString, baseURL: nil)
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        // Do nothing
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.documentElement.style.webkitUserSelect='none';") { (result, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
