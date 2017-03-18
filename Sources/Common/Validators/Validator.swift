//
//  Validator.swift
//  cosmos
//
//  Created by Tue Nguyen on 6/6/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


let ValidatorErrorDomain = "ValidatorError"

struct ValidatorErrorCode {
    static let Require = -1
    static let MaxLength = -2
}

protocol Validator {
    func validateWithError(_ error: NSErrorPointer) -> Bool
}

extension Validator {
    internal func generateError(_ error: NSErrorPointer?, code: Int, errorMessage: String? = nil) {
        guard error != nil else {
            return
        }
        
        var userInfo =  [String: AnyObject]()
        
        if let errorMessage = errorMessage {
            userInfo[NSLocalizedDescriptionKey] = errorMessage as AnyObject?
        }
        
        error??.pointee = NSError(domain: ValidatorErrorDomain, code: code, userInfo: userInfo)
    }
}

class GenericValidator: Validator {
    var input: String?
    var required: Bool = true
    var maximumLength = 0 //No retrict length
    var fieldName: String = NSLocalizedString("Field", comment: "")
    
    func validateWithError(_ error: NSErrorPointer) -> Bool {
        var result = true
        let errorMessage: String
        
        if input == nil || input?.characters.count == 0 {
            errorMessage = String(format:NSLocalizedString("%@ is required.", comment: ""), fieldName)
            result = false
            generateError(error, code: ValidatorErrorCode.Require, errorMessage: errorMessage)
        } else if input?.characters.count > maximumLength {
            errorMessage = String(format:NSLocalizedString("%@ must be less than or equal to %d characters long.", comment: ""), fieldName, maximumLength)
            result = false
            
            generateError(error, code: ValidatorErrorCode.MaxLength, errorMessage: errorMessage)
        }
        
        return result
    }
}

class UsernameValidator: GenericValidator {
    let regexPattern = "^\\w$"
    
    override init() {
        super.init()
        maximumLength = 20
        required = true
    }
    
    override func validateWithError(_ error: NSErrorPointer) -> Bool {
        guard super.validateWithError(error) else {
            return false
        }
        
        var result = true
        let errorMessage: String
        
        if input != nil {
            let regex = try! NSRegularExpression(pattern: regexPattern, options: [])
            let regexResult = regex.matches(in: input!, options:[], range: NSMakeRange(0, input!.characters.count))
            result = regexResult.count > 0
            
            if result == false {
                errorMessage = String(format:NSLocalizedString("%@ contains invalid character", comment:""), fieldName)
                generateError(error, code: ValidatorErrorCode.MaxLength, errorMessage: errorMessage)
            }
        }
        
        return result
    }
}

class PasswordValidator: GenericValidator {
    override init() {
        super.init()
        maximumLength = 50
        required = true
    }
}

class EmailValidator: GenericValidator {
    let regexPattern = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
    
    override init() {
        super.init()
        maximumLength = 100
        required = true
    }
    override func validateWithError(_ error: NSErrorPointer) -> Bool {
        let regex = try! NSRegularExpression(pattern: regexPattern, options: [])
        let regexResult = regex.matches(in: input!, options:[], range: NSMakeRange(0, input!.characters.count))
        let result = regexResult.count > 0
        
        if result == false {
            let errorMessage = String(format:NSLocalizedString("Invalid email address", comment:""))
            generateError(error, code: ValidatorErrorCode.MaxLength, errorMessage: errorMessage)
        }
        
        return result
    }
}


class SetPasswordValidator: Validator {
    var passwordValidator = PasswordValidator()
    var retypePasswordValidator = PasswordValidator()
    
    func validateWithError(_ error: NSErrorPointer) -> Bool {
        guard passwordValidator.validateWithError(error) else {
            return false;
        }
        
        guard retypePasswordValidator.validateWithError(error) else {
            return false;
        }
        
        if passwordValidator.input == retypePasswordValidator.input {
            let errorMessage = NSLocalizedString("Retype password does not match.", comment:"")
            generateError(error, code: ValidatorErrorCode.MaxLength, errorMessage: errorMessage)
        }
        return true
    }
}

class SignUpValidator: Validator {
    var usernameValidator = UsernameValidator()
    var setPasswordValidator = SetPasswordValidator()
    var emailValidator = EmailValidator()
    
    func validateWithError(_ error: NSErrorPointer) -> Bool {
        return true
    }
}
