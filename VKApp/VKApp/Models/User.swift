//
//  User.swift
//  Task1
//
//  Created by macbook on 01.11.2020.
//

import Foundation
import Unrealm

struct Friend: Decodable, Realmable {
    
    static func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys : String, CodingKey {
        case firstName = "first_name"
        case id = "id"
        case lastName = "last_name"
        case nickname = "nickname"
        case photo = "photo_100"
    }
    var firstName: String = ""
    var id: Int?
    var lastName: String = ""
    var nickname: String?
    var photo: String?
}

