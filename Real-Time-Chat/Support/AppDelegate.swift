//
//  AppDelegate.swift
//  Real-Time-Chat
//
//  Created by Kenny on 2020/12/16.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn

@UIApplicationMain

class AppDelegate:UIResponder, UIApplicationDelegate {
    func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? ) -> Bool { ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions )
        
        FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        
        return true
        
    }
    func application( _ app:UIApplication, open url:URL, options: [UIApplication.OpenURLOptionsKey :Any] = [:] ) -> Bool { ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
        
        return GIDSignIn.sharedInstance().handle(url)
    }
    
}
// MARK: Google Delegate
extension AppDelegate: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else { return }
        
      guard  let email = user.profile.email,
        let firstName = user.profile.givenName,
        let lastName = user.profile.familyName else { return  }
        let safeUser = ChatAppUser(firstName: firstName, lastName: lastName, emailAddress: email)
        DataBaseManager.shared.userExists(with: safeUser.safeEmail) { (exists) in
            if !exists {
                /// insert user data to dataBase
                DataBaseManager.shared.insertUser(with: ChatAppUser(firstName: firstName, lastName: lastName, emailAddress: email))
                
            }
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        /// 取得FIreBase授權
        FirebaseAuth.Auth.auth().signIn(with: credential) { (authResult, error) in
            guard authResult != nil, error == nil else { return }
        }
        /// Google 成功登入後
        NotificationCenter.default.post(name: .didLogInNotification, object: nil)
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("User was disconnection with google")
    }
}
