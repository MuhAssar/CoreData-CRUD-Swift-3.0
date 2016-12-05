//
//  EntityTypes.swift
//  CoreDataCRUD
//
//  Created by c0d3r on 03/10/15.
//  Copyright © 2015 io pandacode. All rights reserved.
//
//  Updated to support Swift 3.0 and new CoreData
//  by Muhammad Assar <abu.assar@gmail.com>
//  on 12/05/2016

import Foundation

/**
    Enum for holding different entity type names (Coredata Models)
*/
enum EntityTypes:String {
    case Event = "Event"
    //case Foo = "Foo"
    //case Bar = "Bar"
    
    static let getAll = [Event] //[Event, Foo,Bar]
}
