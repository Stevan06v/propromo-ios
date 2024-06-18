import Foundation
import SwiftUI
import WebKit

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
            case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
            case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
            case .trailing: return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
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
        webView.isUserInteractionEnabled = false
        webView.scrollView.isScrollEnabled = false
        webView.loadHTMLString(svgString, baseURL: nil)
        return webView
    }

    func updateUIView(_: WKWebView, context _: Context) {
        // Nothing to update :)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish _: WKNavigation!) {
            webView.evaluateJavaScript("document.documentElement.style.webkitUserSelect='none';document.documentElement.style.pointerEvents='none';document.documentElement.style.overflow='hidden';") { _, error in
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
