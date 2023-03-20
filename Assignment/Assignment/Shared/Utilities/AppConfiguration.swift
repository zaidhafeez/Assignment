//
//  AppConfiguration.swift
//  Assignment
//
//  Created by Mohammad Zaid on 20/03/23.
//

import Foundation

enum NetworkEnvironment: String {
    case Dev
    case Staging
}

protocol AppConfigurationProtocol {
    var baseUrl: String { get }
    var printServerResponse: Bool { get }
}

struct AppConfiguration: AppConfigurationProtocol {
    private let appEnv: NetworkEnvironment
    static let environmentProcessInfoKey = "appConfigration"

    var printServerResponse: Bool {
        if appEnv == .Dev {
            return true
        }
        
        return false
    }
    
    var baseUrl: String {
        return Bundle.main.infoDictionary?["BASE_URL"] as! String
    }

    init(appEnv: NetworkEnvironment) {
        self.appEnv = appEnv
    }
}

protocol ConfigurationInjection {}
extension ConfigurationInjection {
  var appConfiguration: AppConfigurationProtocol {
    return AppDependencyInjection.appConfiguration
  }
}


struct AppDependencyInjection {
    static var appConfiguration: AppConfigurationProtocol {
        let environment = ProcessInfo.processInfo.environment[AppConfiguration.environmentProcessInfoKey] ?? NetworkEnvironment.Dev.rawValue
        return AppConfiguration(appEnv: NetworkEnvironment.init(rawValue: environment) ?? .Dev)
    }
    
    static var networkManager: AppNetworkProtocol {
        AppNetworkManager.shared
    }
    
    static var trendingPost: TrendingPostAPIRepositoryProtocol {
        TrendingPostUseCase()
    }
}
