//
//  WebViewController.swift
//  Capital_cities
//
//  Created by Alex Paramonov on 17.05.22.
//

import UIKit
import WebKit


class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var url = ""
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setWebView()
    }
    
    private func setWebView() {
        let URL = URL(string: url)!
        webView.load(URLRequest(url: URL))
        webView.allowsBackForwardNavigationGestures = true
    }
}
