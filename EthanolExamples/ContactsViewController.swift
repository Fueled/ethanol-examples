//
//  ContactsViewController.swift
//  EthanolExamples
//
//  Created by hhs-fueled on 24/08/15.
//  Copyright (c) 2015 Fueled Digital Media, LLC.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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



