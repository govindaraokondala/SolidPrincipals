//
//  AppConfig.swift
//  Solid
//
//  Created by Govind on 28/07/24.
//

import Foundation
enum AppConfigKeys {
    case BaseUrl
    
    var value:String {
        set{}
        get {
            switch self {
            case .BaseUrl:
                return "BASE_URL"
            }
        }
    }
}
struct AppConfig {
    static var infoDict:[String:Any] {
        set {}
        get {
            return Bundle.main.infoDictionary ?? [:]
        }
    }
    static func getValue(_ key:String) -> Any? {
        infoDict[key]
    }
    
    static var BaseUrl:String {
        set{}
        get {
            guard let baseUrl = getValue(AppConfigKeys.BaseUrl.value) as? String, !baseUrl.isEmpty else {
                assertionFailure("Base url is missing, please check .xcconfig file")
                return ""
            }
            return baseUrl
        }
    }
}
