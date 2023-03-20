//
//  UIViewExtensions.swift
//  Assignment
//
//  Created by Mohammad Zaid on 20/03/23.
//

import UIKit

extension UIView {
    
    static var nib: UINib {
        return UINib(nibName: className, bundle: nil)
    }
    
    static func reuseIdentifier() -> String {
        return className
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
}

extension UIViewController {
    static var storyboardIdentifier: String {
        return className
    }
}
