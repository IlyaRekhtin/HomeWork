//
//  ViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 12.02.2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var loginLable: UILabel!
    @IBOutlet weak var passwordLable: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSet()
    }

    
    private func startSet () {
        loginTextField.layer.cornerRadius = 10
        passwordTextField.layer.cornerRadius = 10
        enterButton.layer.borderWidth = 1
        enterButton.layer.borderColor = UIColor.lightGray.cgColor
        enterButton.layer.cornerRadius = 10
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = UIColor.lightGray.cgColor
        registerButton.layer.cornerRadius = 10
    }
    
    private func getAlert (_ sender: UIButton) {
        switch sender {
            case enterButton:
                let alert = UIAlertController(title: "Wellcom!", message: "🖖 C возвращением \(loginTextField.text ?? "друг")", preferredStyle: .actionSheet)
                let actionButtonForAlert = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(actionButtonForAlert)
                present(alert, animated: true) {
                    _ = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.closeAlert), userInfo: nil, repeats: false)
                    
                }
            case registerButton:
                let alert = UIAlertController(title: "Wellcom!", message: "🤝 спасибо за регистрацию \(loginTextField.text ?? "друг")", preferredStyle: .actionSheet)
                let actionButtonForAlert = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(actionButtonForAlert)
                present(alert, animated: true) {
                    _ = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.closeAlert), userInfo: nil, repeats: false)
                    
                }
            default:
                break
        }
    }
    
    @objc private func closeAlert() {
        dismiss(animated: true)
    }
                 
    @IBAction func enterButtonAction(_ sender: Any) {
        getAlert(sender as! UIButton)
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        getAlert(sender as! UIButton)
    }
    
}

