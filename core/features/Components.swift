import Foundation
import SwiftUI
import WebKit

extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 08) & 0xFF) / 255,
            blue: Double((hex >> 00) & 0xFF) / 255,
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
        HStack(spacing: 6) {
            ForEach(0 ..< dotCount, id: \.self) { index in
                ZStack {
                    Circle()
                        .frame(width: 30, height: 50)
                        .foregroundColor(
                            index == currentStep - 1 ? Color(hex: 0x9A9A9A) :
                                index < currentStep - 1 ? Color(hex: 0x0D3269) : Color(hex: 0xCCCCCC))
                    if index < dotCount - 1 {
                        Rectangle()
                            .frame(width: 30, height: 5)
                            .foregroundColor(
                                index == currentStep - 1 ? Color(hex: 0x9A9A9A) :
                                    index < currentStep - 1 ? Color(hex: 0x0D3269) : Color(hex: 0xCCCCCC))
                            .offset(x: 22)
                            .zIndex(-1)
                    }
                }
            }
        }
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

    func updateUIView(_: WKWebView, context _: Context) {
        // Do nothing
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish _: WKNavigation!) {
            webView.evaluateJavaScript("document.documentElement.style.webkitUserSelect='none';") { _, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}

struct Components_Previews: PreviewProvider {
    static var previews: some View {
        StepIndicator(currentStep: 2, dotCount: 3)
    }
}
