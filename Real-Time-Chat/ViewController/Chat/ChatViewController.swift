//
//  ViewController.swift
//  Real-Time-Chat
//
//  Created by Kenny on 2020/12/16.
//

import UIKit
import Firebase


class ChatViewController: UIViewController {
    
    private lazy var textField: UITextField = {
       let text = UITextField()
        return text
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .yellow
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkUserDefault()
    }
    
    
    // MARK: - SetupUI
    private func setupTextField() {
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 100).isActive = true
        textField.placeholder = "Type into your NickName"
        
        textField.backgroundColor = .red
        
    }
    
    private func setupButton() {
        view.addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30).isActive = true
        sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        sendButton.setTitle("登入", for: .normal)
        sendButton.setTitleColor(.darkGray, for: .normal)
        sendButton.backgroundColor = .red
        sendButton.layer.cornerRadius = 20
        sendButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1).cgColor
        sendButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        sendButton.layer.shadowOpacity = 1.0
        sendButton.layer.shadowRadius = 0.0
        sendButton.layer.masksToBounds = false
        sendButton.layer.cornerRadius = 4.0
        sendButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        
    }
    
    // MARK: - UserDefault
    func checkUserDefault() {
        let isLoggIn = UserDefaults.standard.bool(forKey: "logged_in")
        if !isLoggIn {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
    // MARK: - Objc
    @objc
    private func loginAction() {
        print("Hello")
    }


}

