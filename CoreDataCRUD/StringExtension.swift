//
//  StringExtension.swift
//  CoreDataCRUD
//
//  Created by c0d3r on 30/09/15.
//  Copyright © 2015 io pandacode. All rights reserved.
//
//  Updated to support Swift 3.0 and new CoreData
//  by Muhammad Assar <abu.assar@gmail.com>
//  on 12/05/2016

import Foundation

extension String {
    /**
        Custom extension method to append Strings
        
        - Parameter str: The string to append to current String
        - Returns: Void
    */
    mutating func append(_ str: String) {
        self = self + str
    }
    
    /**
        Custom extension method to URL encode a String
        
        - Returns: String the URLEncoded String
    */
    mutating func URLEncodedString() -> String? {
        let customAllowedSet =  CharacterSet.urlQueryAllowed
        let escapedString = self.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
        
        return escapedString
    }
}
