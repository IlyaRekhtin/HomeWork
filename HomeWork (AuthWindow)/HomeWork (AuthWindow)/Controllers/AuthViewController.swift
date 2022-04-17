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
        loadWebView()
    }

    private func webViewConfig() {
        self.view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        navigationController?.navigationBar.isHidden = true
        webView.navigationDelegate = self
    }
    
    private func loadWebView(){
        guard let url = ApiManager.shared.getURL(for: .auth, and: .auth) else {return}
       
        let request = URLRequest(url: url)
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
            UserSessionData.data.id = Int(id)!
            UserSessionData.data.token = token
            decisionHandler(.cancel)
            
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else {return}
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
}









// alert
//let alert = UIAlertController(title: "Wellcom!", message: "🤝 спасибо за регистрацию \(loginTextField.text ?? "друг")", preferredStyle: .actionSheet)
//let actionButtonForAlert = UIAlertAction(title: "Ok", style: .default)
//alert.addAction(actionButtonForAlert)
//present(alert, animated: true) {
//    _ = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.closeAlert), userInfo: nil, repeats: false)
//
//}
