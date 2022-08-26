//
//  WebViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 13.06.2022.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKUIDelegate {
    
    private let webView: WKWebView = {
        let webConfog = WKWebViewConfiguration()
        var webView = WKWebView(frame: .zero, configuration: webConfog)
        return webView
    }()
    
    var linkDescription: UILabel = {
        let lable = UILabel(frame: .zero)
        lable.font = UIFont.mainTextFont
        lable.numberOfLines = 1
        return lable
    }()
    
    
    lazy var urlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = linkDescription.text
        webView.uiDelegate = self
        self.view = webView
        loadContent(from: self.urlString)
    }
    
    private func loadContent(from urlStr: String) {
        guard let url = URL(string: urlStr) else {return}
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
