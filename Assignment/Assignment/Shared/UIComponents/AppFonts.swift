//
//  AppFonts.swift
//  Assignment
//
//  Created by Mohammad Zaid on 20/03/23.
//

import UIKit

private struct RobotoAppFont {
    private static let fontFamilyName = "Roboto"
    
    static func getFontWith(style: String, fontSize: CGFloat) -> UIFont? {
        let fontName = "\(fontFamilyName)\(style)"
        return UIFont(name: fontName, size: fontSize)
    }
}

enum FontType: Int {
case Regular = 0, Medium, Bold
    var fontStyle: String {
        switch self {
        case .Regular:
            return "-Regular"
        case .Medium:
            return "-Medium"
        case .Bold:
            return "-Bold"
        }
    }
    
    func getFont(fontSize: CGFloat) -> UIFont  {
        return RobotoAppFont.getFontWith(style: self.fontStyle, fontSize: fontSize)!
    }
}

extension UIFont {
    static func appRegularFont(_ size: CGFloat) -> UIFont {
        return FontType.Regular.getFont(fontSize: size)
    }

    static func appBoldFont(_ size: CGFloat) -> UIFont {
        return FontType.Bold.getFont(fontSize: size)
    }

    static func appMediumFont(_ size: CGFloat) -> UIFont {
        return FontType.Medium.getFont(fontSize: size)
    }
}
