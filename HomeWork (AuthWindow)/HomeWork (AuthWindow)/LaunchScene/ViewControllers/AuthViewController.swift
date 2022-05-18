//
//  ViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 12.02.2022.
//

import UIKit
import WebKit
import SnapKit

class AuthViewController: UIViewController {
    
    private lazy var webView : WKWebView = {
        let webViewConfig = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webViewConfig)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webViewConfig()
    }
}

//MARK: - Private
private extension AuthViewController {
    func webViewConfig() {
        navigationController?.navigationBar.isHidden = true
        webView.navigationDelegate = self
        makeConstraints()
        loadWebView()
    }
    
    func loadWebView(){
        guard  let request = Api.shared.getAuthRequest() else {return}
        webView.load(request)
    }
}

//MARK: - WKNavigationDelegate
extension AuthViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment
        else { decisionHandler(.allow); return }

        let parameters = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }

        if let token = parameters["access_token"], let id = parameters["user_id"] {
            Session.data.id = Int(id)!
            Session.data.token = token
            decisionHandler(.cancel)
            
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LaunchViewController") as? LaunchViewController else {return}
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }
}

//MARK: - make constraints
private extension AuthViewController {
    func makeConstraints() {
        self.view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
