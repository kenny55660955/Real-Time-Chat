//
//  DataBaseManager.swift
//  Real-Time-Chat
//
//  Created by Kenny on 2020/12/17.
//

import Foundation
import FirebaseDatabase



final class DataBaseManager {
    
    static let shared = DataBaseManager()
    
    private let database =  Database.database().reference()
    
    
}
// MARK: - Account Manager
extension DataBaseManager {
    
    public func userExists(with email: String,
                           completion: @escaping ((Bool) -> Void)) {
        
        database.child(email).observeSingleEvent(of: .value) { (snapsShot) in
            guard snapsShot.value as? String != nil else {
                completion(false)
                return
                
            }
            completion(true)
        }
    }
    
    /// Insert new user to dataBase
    public func insertUser(with user: ChatAppUser) {
        
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}
