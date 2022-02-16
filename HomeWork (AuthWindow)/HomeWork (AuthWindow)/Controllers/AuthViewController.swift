//
//  ViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 12.02.2022.
//

import UIKit

class AuthViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var loginLable: UILabel!
    @IBOutlet weak var passwordLable: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSet()
    }

    
    private func startSet () {
       
        
        // loginTextField custom
        loginTextField.layer.cornerRadius = 8
        loginTextField.layer.borderWidth = 1
        loginTextField.layer.borderColor = UIColor.systemGreen.cgColor
        
        
        // passwordTextField custom
        loginTextField.layer.borderWidth = 1
        loginTextField.layer.borderColor = UIColor.systemGreen.cgColor
        
        
        // loginButton custom
        loginButton.layer.cornerRadius = 8
        loginButton.layer.shadowColor = UIColor.systemGreen.cgColor
        loginButton.layer.shadowRadius = 5
        loginButton.layer.shadowOpacity = 0.4
        loginButton.layer.shadowPath = CGPath(rect: CGRect(x: -5, y: 10, width: loginButton.layer.bounds.width + 10, height: loginButton.layer.bounds.height), transform: nil)
        
        //registerButton custom
        registerButton.layer.cornerRadius = 8
        registerButton.layer.shadowColor = UIColor.systemGreen.cgColor
        registerButton.layer.shadowRadius = 5
        registerButton.layer.shadowOpacity = 0.4
        registerButton.layer.shadowPath = CGPath(rect: CGRect(x: -5, y: 10, width: registerButton.layer.bounds.width + 10, height: registerButton.layer.bounds.height), transform: nil)
    }
             
    @IBAction func enterButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "tabBarController", sender: nil)
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "registerViewController", sender: nil)
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
