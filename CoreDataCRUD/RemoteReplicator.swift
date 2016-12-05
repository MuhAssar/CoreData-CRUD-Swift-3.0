//
//  RemoteReplicator.swift
//  CoreDataCRUD
//
//  Created by c0d3r on 04/10/15.
//  Copyright © 2015 io pandacode. All rights reserved.
//
//  Updated to support Swift 3.0 and new CoreData
//  by Muhammad Assar <abu.assar@gmail.com>
//  on 12/05/2016

import Foundation

/**
    Remote Replicator handles calling remote datasource and parsing response JSON data and calls the Core Data Stack,
    (via EventAPI) to actually create Core Data Entities and persist to SQLite Datastore.
*/

class RemoteReplicator : ReplicatorProtocol {
    
    fileprivate var eventAPI: EventAPI!
    fileprivate var httpClient:HTTPClient!
    
    //Utilize Singleton pattern by instanciating Replicator only once.
    class var sharedInstance: RemoteReplicator {
        struct Singleton {
            static let instance = RemoteReplicator()
        }
        
        return Singleton.instance
    }
    
    init() {
        self.eventAPI = EventAPI.sharedInstance
        self.httpClient = HTTPClient()
    }
    
    /**
        Pull event data from a given Remote resource, posts a notification to update
        datasource of a given/listening ViewController/UITableView.
        
        - Returns: Void
    */
    func fetchData() {
        
        //Remote resource
        let request:URLRequest = URLRequest(url: URL(string: "https://www.dropbox.com/s/mq5o0f4fiyl0hwc/remote_events.json?dl=1")!)
        
        httpClient.doGet(request) { (data, error, httpStatusCode) -> Void in
            if httpStatusCode!.rawValue != HTTPStatusCode.ok.rawValue {
                print("\(httpStatusCode!.rawValue) \(httpStatusCode)")
                if data == nil {
                    print("data is nil")
                }
            }
            else {
                //Read JSON response in seperate thread
                DispatchQueue.global(qos: .default).async(execute: {
                    // read JSON file, parse JSON data
                    self.processData(data! as AnyObject?)
                    
                    // Post notification to update datasource of a given ViewController/UITableView
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "updateEventTableData"), object: nil)
                    }
                })
            }
        }
    }
    
    /**
        Process data from a given resource Event objects and assigning
        (additional) property values and calling the Event API to persist Events
        to the datastore.
        
        - Parameter jsonResult: The JSON content to be parsed and stored to Datastore.
        - Returns: Void
    */
    func processData(_ jsonResponse:AnyObject?) {
        
        let jsonData:Data = jsonResponse as! Data
        var jsonResult:Any!
        
        do {
            jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
        } catch let fetchError as NSError {
            print("pull error: \(fetchError.localizedDescription)")
        }

        var retrievedEvents:[Dictionary<String,AnyObject>] = []
        
        if let eventList = jsonResult as? [Dictionary<String, AnyObject>]  {
            for var eventItem in eventList {
                //Create additional event item properties:
                
                //Prefix title with remote(ly) retrieved label
                eventItem[EventAttributes.title.rawValue] = "[REMOTE] \(eventItem[EventAttributes.title.rawValue]!)" as AnyObject

                //Generate event UUID
                eventItem[EventAttributes.eventId.rawValue] = UUID().uuidString as AnyObject?
                
                //Generate semi random generated attendeeslist
                eventItem[EventAttributes.attendees.rawValue] = AttendeesGenerator.getSemiRandomGeneratedAttendeesList() as AnyObject?
                
                retrievedEvents.append(eventItem)
            }
        }
        
        //Call Event API to persist Event list to Datastore
        eventAPI.saveEventsList(retrievedEvents as Array<AnyObject>)
    }
}
