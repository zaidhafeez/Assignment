//
//  StoryboardType.swift
//  Assignment
//
//  Created by Mohammad Zaid on 20/03/23.
//

import UIKit

enum UIStoryBoardType: String {
    case Home = "Home"
    
    var storyboard: UIStoryboard {
        UIStoryboard(name: self.rawValue, bundle: nil)
    }
}
