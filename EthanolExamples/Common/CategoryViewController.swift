//
//  CategoryViewController.swift
//  EthanolExamples
//
//  Created by Stephane Copin on 7/1/15.
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
import EthanolTools
import EthanolUIExtensions

enum Category {
	case UIComponents
	case UIExtensions
	case Utilities
	case Tools
	case Contacts
}

class CategoryViewController: UITableViewController {
	private let ShowDemoListViewControllerSegueIdentifier = "ShowDemoListViewControllerSegueIdentifier"
	private let CategoryViewControllerTableViewCellIdentifier = "CategoryViewControllerTableViewCellIdentifier"
	
	private let categories: [(Category, String, demos: [DemoInformation])] = [
		(.UIComponents, "UI Components", [DemoInformation(name: "TextField", viewControllerClass: TextFieldViewController.self)]),
		(.UIExtensions, "UI Extensions", [DemoInformation(name: "NavigationItem", viewControllerClass: NavigationItemViewController.self),
			DemoInformation(name: "AnimateTransitions", viewControllerClass: AnimateTransitionViewController.self),
			DemoInformation(name: "MapView Helper", viewControllerClass: DemoMapViewController.self)]),
		(.Utilities, "Utilities", [DemoInformation(name: "Object Helpers", viewControllerClass: ObjectHelpersExampleViewController.self)]),
		(.Tools, "Tools", [DemoInformation(name: "Screen Manager", viewControllerClass: ScreenManagerViewController.self)]),
		(.Contacts, "Contacts", [DemoInformation(name: "Contacts") { () -> UIViewController in
			let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
			return mainStoryboard.instantiateViewControllerWithIdentifier("ContactsViewControllerID")
			}]),
	]
	
	private var demosSelected: (String, Array<DemoInformation>)?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CategoryViewControllerTableViewCellIdentifier)
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		print("The top view controller is \(UIViewController.topMostController) \(self.isTopMostController)")
	}
	
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
		print("The top view controller is \(UIViewController.topMostController) \(self.isTopMostController)")
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		guard let demosSelected = self.demosSelected else { return }
		
		if(segue.identifier == ShowDemoListViewControllerSegueIdentifier) {
			let viewController = segue.destinationViewController as! DemoListViewController
			viewController.navigationItem.title = demosSelected.0
			viewController.demos = demosSelected.1
		}
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		self.demosSelected = (self.categories[indexPath.row].1, self.categories[indexPath.row].2)
		self.performSegueWithIdentifier(ShowDemoListViewControllerSegueIdentifier, sender: self)
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.categories.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(CategoryViewControllerTableViewCellIdentifier)!
		cell.textLabel?.text = self.categories[indexPath.row].1
		return cell
	}
}
