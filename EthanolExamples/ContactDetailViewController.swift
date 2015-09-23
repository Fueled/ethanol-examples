//
//  ContactDetailViewController.swift
//  EthanolExamples
//
//  Created by hhs-fueled on 25/08/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
//

import UIKit
import EthanolContacts

class ContactDetailViewController: UIViewController {
	
	@IBOutlet weak var descriptionLabel: UILabel!
	
	var contact: Contact?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.populateContactDetails()
	}
	
	func populateContactDetails(){
		if let contact = contact {
			let descriptionString = "givenName : \(contact.givenName) , familyName : \(contact.familyName) , middleName : \(contact.middleName) , phone : \(contact.phone) , emails : \(contact.emails) , addresses : \(contact.addresses) , organizationName : \(contact.organizationName) , jobTitle : \(contact.jobTitle) , departmentName : \(contact.departmentName) , nickname : \(contact.nickname) , urls : \(contact.urls) , birthdayDate : \(contact.birthdayDate)"
			self.descriptionLabel.text = descriptionString
		}
	}
	
}
