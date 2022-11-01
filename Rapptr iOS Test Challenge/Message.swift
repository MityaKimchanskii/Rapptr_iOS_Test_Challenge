//
//  Message.swift
//  Rapptr iOS Test Challenge
//
//  Created by Mitya Kim on 10/31/22.
//

import Foundation

struct JSONData: Decodable {
    var data: [Message]
}

struct Message: Decodable {
    var userID: String
    var username: String
    var avatarURL: URL?
    var text: String
    
    init(testName: String, withTestMessage message: String) {
        self.userID = "0"
        self.username = testName
        self.avatarURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Smiley.svg/220px-Smiley.svg.png")
        self.text = message
    }
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case username = "name"
        case avatarURL = "avatar_url"
        case text = "message"
    }
}
