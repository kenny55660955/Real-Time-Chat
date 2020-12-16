//
//  ViewController.swift
//  Real-Time-Chat
//
//  Created by Kenny on 2020/12/16.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {
    
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
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .yellow
        setupTextField()
        setupButton()
        signInGoogleDelegate()
//        auth()
        
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
        sendButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        sendButton.setTitle("登入", for: .normal)
        sendButton.setTitleColor(.darkGray, for: .normal)
        sendButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        
    }
    // MARK: - SignInGoogleDelegate
    func signInGoogleDelegate() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
    // MARK: - Objc
    @objc
    private func loginAction() {
//        auth()
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    // MARK: - Auth
    private func auth() {
        
        Auth.auth().signInAnonymously { (authResult, error) in
            
            guard let user = authResult?.user else { return }
            let isAnonymous = user.isAnonymous
            let uid = user.uid
            
            print(user.displayName)
            print(user.email)
            print(user.phoneNumber)
            print(user.uid)
        }
    }


}

extension ViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        
        
        let viewController = ChannelViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}
