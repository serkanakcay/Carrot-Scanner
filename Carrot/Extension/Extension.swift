//
//  Extension.swift
//  Carrot
//
//  Created by serkan on 7.03.2025.
//

import Foundation
extension Encodable{
    func asDictonary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else{
            return [:]
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data) as?[String:Any]
            return json ?? [:]
        }catch{
            return[:]
        }
    }
}
