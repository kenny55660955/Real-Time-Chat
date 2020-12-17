//
//  Chat.swift
//  Real-Time-Chat
//
//  Created by Kenny on 2020/12/16.
//

import UIKit

struct Chat {

    var users: [String]

    var dictionary: [String: Any] {
        return [
            "users": users
        ]
    }
}

extension Chat {

    init?(dictionary: [String:Any]) {
        guard let chatUsers = dictionary["users"] as? [String] else {return nil}
        self.init(users: chatUsers)
    }
}

//}
//import UIKit
//
//struct Chat {
//
//    var users: [String]
//
//    var dictionary: [String: Any] {
//        return ["users": users]
//    }
//
//    init?(dictionary: [String: Any]) {
//
//        guard let chatUsers = dictionary["users"] as? [String] else { return nil }
//        self.
//    }
//}
