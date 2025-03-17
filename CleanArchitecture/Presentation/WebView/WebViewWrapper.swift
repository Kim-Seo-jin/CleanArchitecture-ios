//
//  WebViewWrapper.swift
//  CleanArchitecture
//
//  Created by Chaekyeong Lee on 3/17/25.
//

import SwiftUI
import WebKit

struct WebViewWrapper: UIViewRepresentable {
    @EnvironmentObject private var router: AppRouter
    let url: URL
    private let CONFIG_WEB_NAME = "callAppNative"
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero, configuration: makeConfiguration())
        
        // DI 통해 Router 연결
        BridgeManager.shared.setRouter(router)
        
        webView.configuration.userContentController.add(WebViewContentController(), name: CONFIG_WEB_NAME)
        
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    private func makeConfiguration() -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()
        configuration.preferences.setValue(true, forKey: "developerExtrasEnabled") // 개발자 도구 활성화
        return configuration
    }
}

