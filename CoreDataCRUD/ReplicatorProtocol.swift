//
//  ReplicatorProtocol.swift
//  CoreDataCRUD
//
//  Created by c0d3r on 04/10/15.
//  Copyright © 2015 io pandacode. All rights reserved.
//
//  Updated to support Swift 3.0 and new CoreData
//  by Muhammad Assar <abu.assar@gmail.com>
//  on 12/05/2016

import Foundation

//Methods that must be implemented by every class that extends it.
protocol ReplicatorProtocol {
    func fetchData()
    func processData(_ jsonResult: AnyObject?)
}
