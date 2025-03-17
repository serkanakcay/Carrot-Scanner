//
//  User.swift
//  Carrot
//
//  Created by serkan on 7.03.2025.
//

import Foundation
struct User: Codable{
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval

func asDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "email": email,
            "joined": joined
        ]
    }
}

