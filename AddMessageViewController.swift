//
//  AddMessageViewController.swift
//  SlapChat
//
//  Created by Cenker Demir on 7/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class AddMessageViewController: UIViewController {

    @IBOutlet weak var newMessage: UITextField!
    let dataStore = DataStore.sharedDataStore
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveNewMessage(sender: AnyObject) {
        if let text = self.newMessage.text {
            let messageDescription = NSEntityDescription.entityForName("Message", inManagedObjectContext: dataStore.managedObjectContext)
            
            if let messageDescription = messageDescription {
                let message = Message(entity: messageDescription, insertIntoManagedObjectContext: dataStore.managedObjectContext)
                message.content = text
                message.createdAt = NSDate()
                dataStore.messages.append(message)
                dataStore.saveContext()
            }
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
