//
//  ResourcesExampleTableViewController.swift
//  EthanolExamples
//
//  Created by hhs-fueled on 14/09/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
//

import UIKit
import EthanolUtilities

let resourceFetcherCellIdentifier = "ResourceFetcherCellIdentifier"

class ResourcesExampleTableViewController: UITableViewController {

	let fourSquareFetcher = FourSquareResourceFetcher()

	override func viewDidLoad() {
		super.viewDidLoad()
	}


	// MARK: - Table view data source

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(resourceFetcherCellIdentifier, forIndexPath: indexPath)
		cell.textLabel?.text = "test"
		return cell
	}
}
