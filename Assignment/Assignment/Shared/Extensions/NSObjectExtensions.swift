//
//  NSObjectExtensions.swift
//  Assignment
//
//  Created by Mohammad Zaid on 20/03/23.
//

import Foundation

extension NSObject {
    static var className: String {
        NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
