//
//  UserStorage.swift
//  LabTest
//
//  Created by Wong Tian Haw on 05/07/2022.
//

import Foundation
import UIKit

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}

@propertyWrapper
struct UserDefaultsStorage<Value> {
    
    private let key: String
    private let defaultValue: Value
    private let storage: UserDefaults
    
    init(wrappedValue defaultValue: Value, key: String, storage: UserDefaults = .standard)
    {
        
        self.defaultValue = defaultValue
        self.key = key
        self.storage = storage
    }
    
    var wrappedValue: Value {
        get {
            let value = storage.value(forKey: self.key) as? Value
            return value ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                self.storage.removeObject(forKey: self.key)
            } else {
                self.storage.setValue(newValue, forKey: self.key)
            }
        }
    }
    
}

struct UserStorage {
    // MARK: - keys
    static private let accessTokenKey: String = "accessToken"
    static private let userIdKey: String = "userId"
    
    
    @UserDefaultsStorage<String>(key: accessTokenKey)
    static var accessToken: String = ""
    
    @UserDefaultsStorage<Int>(key: userIdKey)
    static var userId: Int = 0
    
    static func isUserLoggedIn() -> Bool {
        return self.accessToken.isEmpty ? false : true
    }
    
    static func logout() {
        self.accessToken = ""
    }
    
    static func processLogin(token: String) {
        //Save Access Token
        self.accessToken = token
    }
    
}
