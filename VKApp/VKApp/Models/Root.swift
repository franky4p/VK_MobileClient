//
//  Root.swift
//  VKApp
//
//  Created by Pavel Khlebnikov on 02.08.2021.
//

import Foundation
import Unrealm

struct Root<T: Decodable> : Decodable {
    private enum CodingKeys : String, CodingKey { case response = "response" }
    let response : response<T>
}

struct response<T: Decodable> : Decodable {
    private enum CodingKeys : String, CodingKey {
        case items = "items"
        case count = "count"
    }
    let count: Int?
    let items : [T]
}
