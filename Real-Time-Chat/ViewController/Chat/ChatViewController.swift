//
//  ViewController.swift
//  Real-Time-Chat
//
//  Created by Kenny on 2020/12/16.
//

import UIKit
import FirebaseAuth


class ChatViewController: UIViewController {
    
    
    
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
 
    // MARK: - UserDefault
    func checkUserDefault() {
        
        if Auth.auth().currentUser == nil {
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

