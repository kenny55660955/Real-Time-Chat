//
//  LoginViewController.swift
//  Real-Time-Chat
//
//  Created by Kenny on 2020/12/17.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    //Property
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password Address..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20)
        return button
    }()
    
    private let fbLoginButton: FBLoginButton = {
        let button = FBLoginButton()
        button.layer.cornerRadius = 12
        button.permissions = ["email,public_profile"]
        return button
    }()
    
    private let googleLogInButton: GIDSignInButton = {
        let button = GIDSignInButton()
        return button
    }()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGoogle()
        
        addNotifiCation()
        
        addSubView()
        
        view.backgroundColor = .white
        
        setupNaviController()
        
        addButtonAction()
        
        registerDelegate()
    }

    deinit {
        /// 畫面消失移除Notification
        NotificationCenter.default.removeObserver(Notification.Name.didLogInNotification)
        print("did deinit")
    }
    
    
    // MARK: - UI Method
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        let size = scrollView.width / 3
        imageView.frame = CGRect(x: (scrollView.width - size) / 2,
                                 y: 20,
                                 width: size,
                                 height: size)
        
        emailField.frame = CGRect(x: 30,
                                  y: imageView.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 52)
        
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        
        loginButton.frame = CGRect(x: 30,
                                   y: passwordField.bottom + 10,
                                   width: scrollView.width - 60,
                                   height: 52)
        
        fbLoginButton.frame = CGRect(x: 30,
                                     y: loginButton.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        googleLogInButton.frame = CGRect(x: 30,
                                         y: fbLoginButton.bottom + 10,
                                         width: scrollView.width - 60,
                                         height: 52)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupNaviController() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
    }
    
    private func registerDelegate() {
        emailField.delegate = self
        passwordField.delegate = self
        fbLoginButton.delegate = self
    }
    
    private func addSubView() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(fbLoginButton)
        scrollView.addSubview(googleLogInButton)
    }
    
    private func addButtonAction() {
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    // MARK: - Google
    private func setupGoogle() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    private func addNotifiCation() {
        NotificationCenter.default.addObserver(forName: .didLogInNotification, object: nil, queue: .main) { [weak self] (_) in
            guard let self = self else { return }
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    // MARK: - objc Method
    @objc
    private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func didTapLoginButton() {
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        ///FireBase Login
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let strongSelf = self,
                  let result = authResult , error == nil else {
                print("Failed to log in user with email : \(email)")
                return
            }
            
            let user = result.user
            print("Logged In User: \(user)")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        }
        
    }
    
    private func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops",
                                      message: "Please enter all Info to Log in",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dissmiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
        
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapLoginButton()
        }
        return true
    }
}
// MARK: FB登入Button Delegate
extension LoginViewController: LoginButtonDelegate {
    // 登入
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        guard let token = result?.token?.tokenString else {
            print("User failed log in with faceBook")
            return
        }
        /// 紀錄FB登入到FireBase
        let facebookRequest = FBSDKLoginKit.GraphRequest(graphPath: "Me",
                                                         parameters: ["fields" : "email,name"],
                                                         tokenString: token,
                                                         version: nil,
                                                         httpMethod: .get)
        facebookRequest.start { (_, result, error) in
            guard let result = result as? [String: Any],
                  error == nil else {
                print("Failed to make Facebook graph request")
                return
            }
            print("\(result)")
            
            let creatial = FacebookAuthProvider.credential(withAccessToken: token)
            
            Auth.auth().signIn(with: creatial) { [weak self] (authResult, error) in
                guard let self = self else { return }
                guard authResult != nil,
                      error == nil else {
                    if let error = error {
                        print("error - \(error)")
                    }
                    return
                }
                print("\(result)")
                /// 判斷是否有取得userName 和 email
                guard let userName = result["name"] as? String,
                      let email = result["email"] as? String else {
                    print("Fail to Get Email and name from FB")
                    return
                }
                /// 必須先實體化，如後拿裡面已經轉換的safe mail
                let user = ChatAppUser(firstName: userName, lastName: userName, emailAddress: email)
                /// 如果有取得Email 和 userName 就存到DataBase
                DataBaseManager.shared.userExists(with: user.safeEmail) { (exists) in
                    if !exists {
                        DataBaseManager.shared.insertUser(with: ChatAppUser(firstName: userName, lastName: userName, emailAddress: email))
                    }
                }
                self.navigationController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    // 登出
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        // no operation
    }
}
