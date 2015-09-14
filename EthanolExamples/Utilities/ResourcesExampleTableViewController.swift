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

	let customFetcher = CustomResourceFetcher()
	var dataSource: [AnyObject] = []
	var loadMoreActivity: UIActivityIndicatorView?
	var isLoading = false
	var needsToLoadMoreData = true

	override func viewDidLoad() {
		super.viewDidLoad()
		customFetcher.startFetchingProducts { (inner) -> Void in
			do {
				let result = try inner()
				self.dataSource = result.objects
				self.tableView.reloadData()
			} catch {
				print("error occurred.")
			}
		}
	}

	func addLoadMore(){
		if self.tableView.numberOfRowsInSection(0) == 0 {
			return;
		}
		guard let _ = self.loadMoreActivity else {
			self.loadMoreActivity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
			let screenWidth = UIScreen.mainScreen().bounds.size.width
			self.loadMoreActivity!.frame = CGRectMake(0.0, 0.0, screenWidth, 44.0);
			self.loadMoreActivity?.startAnimating()
			self.tableView.tableFooterView = self.loadMoreActivity
			return
		}

		self.loadMoreActivity?.startAnimating()
		self.tableView.tableFooterView = self.loadMoreActivity

	}

	func removeLoadMore() {
		loadMoreActivity?.stopAnimating()
		self.tableView.tableFooterView = nil;
	}


	func fetchNextPage() {
		if isLoading {
			return
		}
		isLoading = true
		customFetcher.fetchNextPage { (inner) -> Void in
			do {
				let result = try inner()
				self.dataSource += result.objects
				self.appendCellsForMoreObjects(result.objects.count)
//				self.tableView.reloadData()
				self.needsToLoadMoreData = result.hasMoreDataToLoad
				self.isLoading = false
			} catch {
				print("error occurred.")
			}
		}
	}

	func appendCellsForMoreObjects(objectsCount:Int) {

		let previousCellCount = self.tableView.numberOfRowsInSection(0)

		let nextCellCount = previousCellCount + objectsCount;
		if nextCellCount > previousCellCount {
			var indexPaths: [NSIndexPath] = []
			for counter in previousCellCount..<nextCellCount {
				let indexPath = NSIndexPath(forRow: counter, inSection: 0)
				indexPaths.append(indexPath)
			}
			tableView.beginUpdates()
			tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.None)
			tableView.endUpdates()
		}
	}

	// MARK: - Table view data source

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSource.count
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(resourceFetcherCellIdentifier, forIndexPath: indexPath)
		let fetchedObject = dataSource[indexPath.row] as! String
		cell.textLabel?.text = fetchedObject
		return cell

	}

	// MARK: UIScrollViewDelegate Methods
	override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		if shouldShowLoadMoreFor(scrollView) && scrollView.contentOffset.y > 0 {
			fetchNextPage()
		}
	}

	func shouldShowLoadMoreFor(scrollView:UIScrollView) -> Bool{
		let currentOffset = scrollView.contentOffset
		let scrollViewBounds = scrollView.bounds
		let scrollViewContentSize = scrollView.contentSize
		let scrollViewInsets = scrollView.contentInset

		let bottomScrolledYPosition = currentOffset.y + scrollViewBounds.size.height + scrollViewInsets.bottom
		let scrollViewContentHeight = scrollViewContentSize.height
		let reloadDistance: CGFloat = 0.0
		return ((bottomScrolledYPosition - scrollViewContentHeight + reloadDistance - 44.0 + 100.0) > 0 && self.needsToLoadMoreData);
	}
	
}
