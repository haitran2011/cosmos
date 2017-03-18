//
//  UserSession.swift
//  cosmos
//
//  Created by Tue Nguyen on 4/22/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import KeychainAccess

let KeychainAccessToken = "AccessToken"
let KeychainUserId = "UserId"

class UserSession {
    let userId:String
    let accessToken:String
    
    static let keychain = Keychain(service: AppInfo.bundleId())
    
    init(userId:String, accessToken:String) {
        self.userId = userId
        self.accessToken = accessToken
    }
    
    fileprivate static var globalSession: UserSession?
    class func currentSession()->UserSession? {
        //load from keychains
        if globalSession == nil {
            let userId = keychain[KeychainUserId]
            let accessToken = keychain[KeychainAccessToken]
            if let userId = userId, let accessToken = accessToken {
                globalSession = UserSession(userId: userId, accessToken: accessToken)
            }
        }
        
        return globalSession
    }
    
    class func setCurrentSession(_ session:UserSession?) {
        globalSession = session
        
        if session == nil {
            keychain[KeychainUserId] = nil
            keychain[KeychainAccessToken] = nil
        } else {
            keychain[KeychainUserId] = session?.userId
            keychain[KeychainAccessToken] = session?.accessToken
        }
    }
}
