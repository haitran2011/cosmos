//
//  Array+Extention.swift
//  MilkyChat
//
//  Created by tienle on 2/6/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import Foundation

extension Array {
    func groupBy<G: Hashable>(groupClosure: (Element) -> G) -> [[Element]] {
        var groups = [[Element]]()
        
        for element in self {
            let key = groupClosure(element)
            var active = Int()
            var isNewGroup = true
            var array = [Element]()
            
            for (index, group) in groups.enumerated() {
                let firstKey = groupClosure(group[0])
                if firstKey == key {
                    array = group
                    active = index
                    isNewGroup = false
                    break
                }
            }
            
            array.append(element)
            
            if isNewGroup {
                groups.append(array)
            } else {
                groups.remove(at: active)
                groups.insert(array, at: active)
            }
        }
        
        return groups
    }
    
    
}

public extension Sequence {
    func categorise<U : Hashable>(_ key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var dict: [U:[Iterator.Element]] = [:]
        for element in self {
            let key = key(element)
            if case nil = dict[key]?.append(element) {
                dict[key] = [element]
            }
        }
        return dict
    }
}
