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
let ContactDetailSegueIdentifier = "ShowContactDetailSegue"

class ContactsViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	var dataSource = [Contact]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.fetchContacts()
	}
	
	func fetchContacts(){
		let properties = ContactProperty.AllProperties
		PhoneContactFetcher.contactFetcher.fetchContactsForProperties(properties,
			success: { contacts in
				self.updateDataSourceAndReloadData(contacts)
			}, failure: { error in
				print("error \(error)")
				self.updateDataSourceAndReloadData([])
		})
	}
	
	func updateDataSourceAndReloadData(contacts:[Contact]){
		self.dataSource = contacts
		self.tableView.reloadData()
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let contact = sender as? Contact where segue.identifier == ContactDetailSegueIdentifier {
			let dvc = segue.destinationViewController as! ContactDetailViewController
			dvc.contact = contact
		}
	}
}

// MARK: - UITableViewDataSource
extension ContactsViewController: UITableViewDataSource {
	
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

// MARK: - UITableViewDelegate
extension ContactsViewController: UITableViewDelegate {
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		self.performSegueWithIdentifier(ContactDetailSegueIdentifier, sender:self.dataSource[indexPath.row])
	}
}



