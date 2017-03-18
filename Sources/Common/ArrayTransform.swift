//
//  ArrayTransform.swift
//  MilkyChat
//
//  Created by Thanh Nguyen on 1/3/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class ArrayTransform<T:RealmSwift.Object> : TransformType where T:Mappable {
    
    
    typealias Object = List<T>
    typealias JSON = Array<AnyObject>
    
    public func transformFromJSON(_ value: Any?) -> List<T>? {
        let result = List<T>()
        if let tempArr = value as! Array<AnyObject>? {
            for entry in tempArr {
                let mapper = Mapper<T>()
                let model : T = mapper.map(JSONObject: entry)!
                result.append(model)
            }
        }
        return result
    }
    
    func transformToJSON(_ value: List<T>?) -> Array<AnyObject>? {
        guard let _ = value else{
            return nil
        }
        if ((value?.count)! > 0)
        {
            var result = Array<T>()
            for entry in value! {
                result.append(entry)
            }
            return result
        }
        return nil
    }
}
