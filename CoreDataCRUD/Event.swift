//
//  Event.swift
//  CoreDataCRUD
//  Written by Steven R.
//
//  Updated to support Swift 3.0 and new CoreData
//  by Muhammad Assar <abu.assar@gmail.com>
//  on 12/05/2016

import Foundation
import CoreData

/**
    Enum for Event Entity member fields
*/
enum EventAttributes : String {
    case
    eventId    = "eventId",
    title      = "title",
    date       = "date",
    venue      = "venue",
    city       = "city",
    country    = "country",
    attendees  = "attendees",
    fb_url      = "fb_url",
    ticket_url = "ticket_url"
    
    static let getAll = [
        eventId,
        title,
        date,
        venue,
        city,
        country,
        attendees,
        fb_url,
        ticket_url
    ]
}

@objc(Event)

/**
    The Core Data Model: Event
*/
class Event: NSManagedObject {
    @NSManaged var attendees: AnyObject
    @NSManaged var city: String
    @NSManaged var country: String
    @NSManaged var venue: String
    @NSManaged var eventId: String
    @NSManaged var date: Date
    @NSManaged var fb_url: AnyObject
    @NSManaged var ticket_url: AnyObject
    @NSManaged var title: String
}

