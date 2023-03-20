//
//  EncodableExtension.swift
//  Assignment
//
//  Created by Mohammad Zaid on 20/03/23.
//

import Foundation
extension Encodable {
    var asDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }

        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return nil
        }
        return dictionary
    }
}
