////
////  Message.swift
////  Real-Time-Chat
////
////  Created by Kenny on 2020/12/16.
////
//
//import Foundation
//import Firebase
//import MessageKit
//
//struct Message {
//    var id: String
//
//    var content: String
//
//    var createdTime: Timestamp
//
//    var senderId: String
//
//    var senderName: String
//
//    var dictionary: [String: Any] {
//        return [
//            "id": id,
//            "content": content,
//            "createdTime": createdTime,
//            "senderId": senderId,
//            "senderName": senderName
//        ]
//    }
//}
//
//extension Message {
//    init?(dictionary: [String: Any]) {
//        guard let id = dictionary["id"] as? String,
//              let content = dictionary["content"] as? String,
//              let createdTime = dictionary["createdTime"] as? Timestamp,
//              let senderId = dictionary["senderId"] as? String,
//              let senderName = dictionary["senderName"] as? String
//        else { return nil }
//        self.init(id: id, content: content, createdTime: createdTime, senderId: senderId, senderName: senderName)
//    }
//}
//
//// MARK: - Message Type
//// MessageKit 一定要用Message type
//extension Message: MessageType {
//
//    var sender: SenderType {
////        return Sender(id: senderId, displayName: senderName)
//
//    }
//
//    var messageId: String {
//        return id
//    }
//
//    var sentDate: Date {
//        return createdTime.dateValue()
//    }
//
//    var kind: MessageKind {
//        return .text(content)
//    }
//
//
//}
