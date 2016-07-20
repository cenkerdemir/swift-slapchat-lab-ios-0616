//
//  TableViewController.swift
//  SlapChat
//
//  Created by susan lovaglio on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var messages: [Message] = []
    let dataStore = DataStore.sharedDataStore
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.dataStore.fetchData()
        self.messages = self.dataStore.messages
        
        if self.messages.count == 0 {
            self.dataStore.generateTestData()
            self.messages = self.dataStore.messages
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataStore.messages.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var celltoReturn = UITableViewCell()
        var label: String = ""
            if let cell = tableView.dequeueReusableCellWithIdentifier("basicCell") {
                if let date = self.dataStore.messages[indexPath.row].createdAt {
                    label = " " + date.description
                }
                if let content = self.dataStore.messages[indexPath.row].content {
                    label = content.debugDescription + label
                }
                cell.textLabel?.text = label
                celltoReturn = cell
            }
        return celltoReturn
    }
    
    @IBAction func sortArray(sender: UIBarButtonItem) {
        let fetchRequest = NSFetchRequest(entityName: "Message")
        let sd = NSSortDescriptor.init(key: "createdAt", ascending: false)
        fetchRequest.sortDescriptors = [sd]
        do {
            self.dataStore.messages = try self.dataStore.managedObjectContext.executeFetchRequest(fetchRequest) as! [Message]
        } catch let nserror as NSError {
            print("There was an an error: \(nserror)")
        }
        self.tableView.reloadData()
    }
    
}
