//
//  DataStore.swift
//  cosmos
//
//  Created by Tue Nguyen on 4/22/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import RealmSwift

class DataStore {
    static let sharedInstance = DataStore()
    let realm:Realm
    
    init() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
       #if DEBUG
            realm = try! Realm()
       #else
            realm = try! Realm()
            /*
             let key = DataStore.getKey()
             LogDebug("====> DB Encryp key:\(key)")
             // Open the encrypted Realm file
             let config = Realm.Configuration(encryptionKey: key)
             do {
             realm = try Realm(configuration: config)
             // Use the Realm as normal
             } catch let error as NSError {
             // If the encryption key is wrong, `error` will say that it's an invalid database
             fatalError("Error opening realm: \(error)")
             }
             */
        #endif
        LogDebug("Realm Path: ====\n\(Realm.Configuration.defaultConfiguration.fileURL)\"\n======")
    }
    static func getKey() -> Data {
        // Identifier for our keychain entry - should be unique for your application
        let keychainIdentifier = "milkyChat.Realm.EncryptionKey"
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        // First check in the keychain for an existing key
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]
        
        // To avoid Swift optimization bug, should use withUnsafeMutablePointer() function to retrieve the keychain item
        // See also: http://stackoverflow.com/questions/24145838/querying-ios-keychain-using-swift/27721328#27721328
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            return dataTypeRef as! Data
        }
        
        // No pre-existing key from this application, so generate a new one
        //        let keyData = NSMutableData(length: 64)!
        //        let result = SecRandomCopyBytes(kSecRandomDefault, 64, UnsafeMutablePointer<UInt8>(keyData.mutableBytes))
        var keyData = Data(count: 64)
        let result = keyData.withUnsafeMutableBytes {mutableBytes in
            SecRandomCopyBytes(kSecRandomDefault, keyData.count, mutableBytes)
        }
        assert(result == 0, "Failed to get random bytes")
        
        // Store the key in the keychain
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: keyData as AnyObject
        ]
        
        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
        
        return keyData as Data
    }
    //MARK: clear DB
    func clearDB() {
        try! realm.write({
            realm.deleteAll();
        })
    }
    
    func save(_ user: AnyObject) -> Bool {
        //Do something to save user data
        return true
    }
    func fetchUser(_ userId: String) -> AnyObject? {
        //write saving query
        return nil
    }
}
//MARK: Video process
extension DataStore{
    @discardableResult func addVideoItem(_ videoItem: VideoDetailItem) -> Bool{
        let allData = realm.objects(VideoDetailItem.self)
        let eventList = allData.filter("videoID == '\(videoItem.videoID!)'")
        if eventList.count > 0{
            return false
        }
        try! realm.write({
            realm.add(videoItem)
            if allData.count > 16{
                let firstItem = allData.first
                if (firstItem?.isInvalidated)! {
                    print("Invalid first item")
                  return
                }
                realm.delete(firstItem!)
            }
        })
        return true
    }
    func deleteVideoItem(_ videoItem: VideoDetailItem) {
        try! realm.write {
            realm.delete(videoItem)
        }
    }
    func fetchAllVideoItemToDisplay() -> [VideoDetailItem] {
        var eventList: Results<VideoDetailItem> = realm.objects(VideoDetailItem.self)
        eventList = eventList.sorted(byKeyPath: "publishedAt", ascending: false)
        var result = [VideoDetailItem]()
        for eventItem:VideoDetailItem in eventList {
            result.append(eventItem)
        }
        return result
    }
}
