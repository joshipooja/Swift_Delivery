//
//  AppConfiguration.swift
//  SwiftDelivery
//
//  Created by  on 14/04/19.
//  Copyright © 2019  . All rights reserved.
//

import UIKit

/*
 Open your Project Build Settings and search for “Swift Compiler – Custom Flags” … “Other Swift Flags”.
 Add “-DDEVELOPMENT” to the Debug section
 Add “-DQA” to the QA section
 Add “-DSTAGING” to the Staging section
 Add “-DPRODUCTION” to the Release section
 */
enum Environment: String {
    case debug
    
    /**
     Returns application selected build configuration/environment
     
     - returns: An application selected build configuration/environment. Default is Development.
     */
    static func currentEnvironment() -> Environment {
        return Environment.debug
        /* let environment = Bundle.main.infoDictionary?["ActiveConfiguration"] as? String
         return environment */
    }
}

final class AppConfiguration {
    /**
     * Application Configuration
     */
    struct Configuration {
        var environment: Environment
        var apiEndPoint: String
        
        fileprivate static func debugConfiguration() -> Configuration {
            return Configuration(environment: .debug,
                                 apiEndPoint: "https://mock-api-mobile.dev.lalamove.com/")
        }
    }
    
    // MARK: - Singleton Instance
    class var shared: AppConfiguration {
        struct Singleton {
            static let instance = AppConfiguration()
        }
        return Singleton.instance
    }
    
    public private(set) var activeConfiguration: Configuration!
    
    private init() {
        // Load application selected environment and its configuration
        activeConfiguration = configurationForEnvironment(Environment.currentEnvironment())
    }
    
    /**
     Returns application active configuration
     
     - parameter environment: An application selected environment
     
     - returns: An application configuration structure based on selected environment
     */
    private func configurationForEnvironment(_ environment: Environment) -> Configuration {
        switch environment {
        case .debug:
            return Configuration.debugConfiguration()
        }
    }
}
