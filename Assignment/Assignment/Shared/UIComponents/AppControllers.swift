//
//  AppControllers.swift
//  Assignment
//
//  Created by Mohammad Zaid on 20/03/23.
//

import UIKit

enum ControllerType {
    case home
    
    private var storyboardType: UIStoryBoardType {
        switch self {
        case .home:
            return .Home
        }
    }
    
    private var controllerIdentifier: String {
        switch self {
        case .home:
            return HomeViewController.storyboardIdentifier
        }
    }
    
    var controller: UIViewController {
        switch self {
        default:
        let controller = storyboardType.storyboard.instantiateViewController(withIdentifier: controllerIdentifier)
            return controller
        }
    }
}
