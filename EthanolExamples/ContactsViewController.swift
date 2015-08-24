//
//  ContactsViewController.swift
//  EthanolExamples
//
//  Created by hhs-fueled on 24/08/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
//

import UIKit
import EthanolContacts

let ContactsCellIdentifier = "ContactsCell"

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  
  var dataSource:[Contact] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.fetchContacts()
  }
  
  func fetchContacts(){
    let properties = ContactProperty.BasicProperties
    
    if #available(iOS 9.0, *) {
      PhoneContactFetcher().fetchContactsForProperties(properties,
        success: { (contacts) -> Void in
          self.updateDataSourceAndReloadData(contacts)
          
        }, failure: { (error) -> Void in
          print("error \(error)")
          self.updateDataSourceAndReloadData([])
      })
    } else {
      // Fallback on earlier versions
      self.updateDataSourceAndReloadData([])
    }
    
  }
  
  func updateDataSourceAndReloadData(contacts:[Contact]){
    self.dataSource = contacts
    self.tableView.reloadData()
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(ContactsCellIdentifier)!
    
    let contact = self.dataSource[indexPath.row]
    cell.textLabel?.text = contact.givenName
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dataSource.count
  }
  
}
