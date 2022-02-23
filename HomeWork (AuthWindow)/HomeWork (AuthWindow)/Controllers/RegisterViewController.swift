//
//  RegisterViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSet()
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @objc func test() {
        print("test")
        
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
        
        //registerButton custom
        addButton.layer.cornerRadius = 8
        addButton.layer.shadowColor = UIColor.systemGreen.cgColor
        addButton.layer.shadowRadius = 5
        addButton.layer.shadowOpacity = 0.4
        addButton.layer.shadowPath = CGPath(rect: CGRect(x: -5, y: 10, width: addButton.layer.bounds.width + 10, height: addButton.layer.bounds.height), transform: nil)
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        // TODO API
        dismiss(animated: true)
    }
    
    

}
