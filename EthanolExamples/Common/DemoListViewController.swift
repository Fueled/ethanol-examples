//
//  DemoListViewController.swift
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
import EthanolUIExtensions
import EthanolTools

class DemoListViewController: UITableViewController {
	private let DemoListViewControllerTableViewCellIdentifier = "DemoListViewControllerTableViewCellIdentifier"
	
	var demos: [DemoInformation]?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: DemoListViewControllerTableViewCellIdentifier)
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		print("The top view controller is \(UIViewController.topMostController)")
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		guard let demos = self.demos else { return }
		
		let viewController = demos[indexPath.row].viewController
		self.navigationController?.pushViewController(viewController, animated: true)
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.demos?.count ?? 0
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		guard let demos = self.demos else { return UITableViewCell() }
		
		let cell = tableView.dequeueReusableCellWithIdentifier(DemoListViewControllerTableViewCellIdentifier)!
		cell.textLabel?.text = demos[indexPath.row].name
		return cell
	}
}
