//
//  TextFieldStyle.swift
//  Propromo
//
//  Created by Jonas Fröller on 09.03.24.
//

import Foundation
import SwiftUI
import WebKit

extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

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

struct StepIndicator: View {
    let currentStep: Int
    let dotCount: Int
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<dotCount, id: \.self) { index in
                ZStack {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundColor(
                            index == currentStep - 1 ? Color(hex: 0x9a9a9a) :
                            index < currentStep - 1 ? Color(hex: 0x0D3269) : Color(hex: 0xcccccc))
                    if index < dotCount - 1 {
                        Rectangle()
                            .frame(width: 8, height: 5)
                            .foregroundColor(
                                index == currentStep - 1 ? Color(hex: 0x9a9a9a) :
                                index < currentStep - 1 ? Color(hex: 0x0D3269) : Color(hex: 0xcccccc))
                            .offset(x: 22)
                            .zIndex(-1)
                    }
                }
            }
        }
    }
}

struct StepIndicator_Previews: PreviewProvider {
    static var previews: some View {
        StepIndicator(currentStep: 2, dotCount: 3)
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
