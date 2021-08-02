//
//  Group.swift
//  Task1
//
//  Created by macbook on 01.11.2020.
//

import Foundation
import Unrealm
import UIKit

class Group {
    var name: String
    var avatar = UIImage(named: "icons8-socrates-50")
    
    init(_ name: String) {
        self.name = name
    }
}

struct MyGroup: Decodable, Realmable {
    
    static func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys : String, CodingKey {
        case id = "id"
        case name = "name"
        case photo = "photo_100"
        case screenName = "screen_name"
    }
    
    var id: Int?
    var name: String = ""
    var photo: String?
    var screenName: String = ""
}


extension Group: CustomStringConvertible {
    var description: String {
        return """
        \(name) 
        """
    }
}
