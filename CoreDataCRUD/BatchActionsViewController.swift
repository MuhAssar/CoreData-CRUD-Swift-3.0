//
//  BatchActionsViewController.swift
//  CoreDataCRUD
//  Written by Steven R.
//
//  Updated to support Swift 3.0 and new CoreData
//  by Muhammad Assar <abu.assar@gmail.com>
//  on 12/05/2016

import UIKit

/**
    Batch Actions View Controller, contains the replication and batch operation actions.
*/
class BatchActionsViewController: UIViewController {

    fileprivate var eventAPI: EventAPI!
    fileprivate var localReplicator: LocalReplicator!
    fileprivate var remoteReplicator: RemoteReplicator!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.eventAPI = EventAPI.sharedInstance
        self.localReplicator = LocalReplicator.sharedInstance
        self.remoteReplicator = RemoteReplicator.sharedInstance
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func anonimizeListButtonTapped(_ sender: AnyObject) {
        eventAPI.anonimizeAttendeesList()
        let _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func deleteAllEventsButtonTapped(_ sender: AnyObject) {
        eventAPI.deleteAllEvents()       
        let _ = self.navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func restoreEventsButtonTapped(_ sender: AnyObject) {
        localReplicator.fetchData()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "setStateLoading"), object: nil)
        let _ = self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func replicateRemoteDataButtonTapped(_ sender: AnyObject) {
        remoteReplicator.fetchData()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "setStateLoading"), object: nil)
        let _ = self.navigationController?.popToRootViewController(animated: true)

    }
}
