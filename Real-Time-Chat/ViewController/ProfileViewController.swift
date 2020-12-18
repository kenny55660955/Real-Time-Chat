//
//  ProfileViewController.swift
//  Real-Time-Chat
//
//  Created by Kenny on 2020/12/17.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class ProfileViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    private let data = ["Log Out"]
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        
        setupDelegate()
        
        registerCell()
        
        setupTableView()
        
        view.backgroundColor = .red
    }
    
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerCell() {
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
}
// MARK: - TableViewDelegate
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
        cell.textLabel?.text = "Log out"
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { [weak self] (_) in
            guard let self = self else { return }
            
            /// Log out facebook
            FBSDKLoginKit.LoginManager().logOut()
            
            /// Google log out
            GIDSignIn.sharedInstance()?.signOut()
            
            do {
                try? Auth.auth().signOut()
                
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            } catch {
                print("Failed to log out")
            }
            
        }))
        present(alert, animated: true)
        
        
    }
    
    
}
