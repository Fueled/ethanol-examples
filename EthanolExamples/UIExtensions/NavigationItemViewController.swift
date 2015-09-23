//
//  NavigationItemViewController.swift
//  EthanolExamples
//
//  Created by hhs-fueled on 17/08/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
//

import UIKit
import EthanolUIExtensions

class NavigationItemViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupNavigationBar()
	}
	
	func setupNavigationBar(){
		self.navigationItem.setCustomBackButtonWithTitle("Custom", target:self, selector: "backTapped")
  
		let attributedString = NSMutableAttributedString(string: "This is attributed title")
		
		var range = NSMakeRange(0, attributedString.length)
		attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGrayColor(), range:range)
		
		range = NSMakeRange(0, attributedString.length-3)
		attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range:range)
		
		let font = UIFont(name: "AvenirNext-Regular", size: 22.0)!
		attributedString.addAttribute(NSFontAttributeName, value: font, range: range)
		self.navigationItem.attributedTitle = attributedString
	}
	
	func backTapped(){
		self.navigationController?.popViewControllerAnimated(true)
	}
}
