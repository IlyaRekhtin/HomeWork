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
    @IBOutlet weak var toggle: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        startSet()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isAuth()
    }
    
    private func startSet () {
       
        // loginTextField custom
        loginTextField.layer.cornerRadius = 5
        loginTextField.layer.borderWidth = 2
        loginTextField.layer.borderColor = UIColor.systemGreen.cgColor
        
        
        // passwordTextField custom
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.borderColor = UIColor.systemGreen.cgColor
        
        
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
    
    private func isAuth() {
        guard (UserDefaults.standard.object(forKey: "login") as? String != nil) else {return}
        guard (UserDefaults.standard.object(forKey: "password") as? String != nil) else {return}
        performSegue(withIdentifier: "tabBarViewController", sender: nil)
    }
             
    @IBAction func enterButtonAction(_ sender: Any) {
        guard loginTextField.text != "" else { return }
        guard passwordTextField.text != "" else { return }
        
        //  TODO метод проверки пароля и логина API
        
        // если на чужом устройстве то не сохраняем данные в настройки пользователя
        // если на своем то сохраняем и пропускаем контроллер авторизации при след запуске
        switch toggle.isOn {
        case true:
            break
        case false:
            UserDefaults.standard.setValue(loginTextField.text, forKey: "login")
            UserDefaults.standard.setValue(passwordTextField.text, forKey: "password")
        }
        loginTextField.text?.removeAll()
        passwordTextField.text?.removeAll()
        performSegue(withIdentifier: "tabBarViewController", sender: nil)
        
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "registerViewController", sender: nil)
    }
    
    @IBAction func toggleAction(_ sender: Any) {
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
