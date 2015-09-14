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
let startResourceFetcherOffset: CGFloat = 100.0
let loadMoreHeight: CGFloat = 44.0

class ResourcesExampleTableViewController: UITableViewController {

	let customFetcher = CustomResourceFetcher()
	var dataSource: [AnyObject] = []
	var loadMoreActivity: UIActivityIndicatorView?
	var isLoading = false
	var needsToLoadMoreData = true

	// MARK: - Lifecycle Methods

	override func viewDidLoad() {
		super.viewDidLoad()
		customFetcher.startFetchingProducts { (inner) -> Void in
			do {
				let result = try inner()
				self.dataSource = (result.resourceFetcher?.allObjects) ?? []
				self.tableView.reloadData()

				if result.hasMoreDataToLoad {
					self.addLoadMore()
				}
			} catch {
				print("Error : \(error)")
			}
		}
	}

	// MARK: - Custom Helper Methods

	func addLoadMore(){
		if tableView.numberOfRowsInSection(0) == 0 {
			return
		}
		guard let _ = loadMoreActivity else {
			loadMoreActivity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
			let screenWidth = UIScreen.mainScreen().bounds.size.width
			loadMoreActivity!.frame = CGRectMake(0.0, 0.0, screenWidth, loadMoreHeight)
			animateLoadMoreActivity()
			return
		}
		animateLoadMoreActivity()
	}

	func animateLoadMoreActivity() {
		loadMoreActivity?.startAnimating()
		tableView.tableFooterView = loadMoreActivity
	}

	func removeLoadMore() {
		loadMoreActivity?.stopAnimating()
		tableView.tableFooterView = nil
	}

	func fetchNextPage() {
		if isLoading {
			return
		}
		isLoading = true
		customFetcher.fetchNextPage { (inner) -> Void in
			do {
				let result = try inner()
				self.dataSource = (result.resourceFetcher?.allObjects) ?? []
				self.tableView.reloadData()
				self.needsToLoadMoreData = result.hasMoreDataToLoad
				self.isLoading = false
				if result.hasMoreDataToLoad == false {
					self.removeLoadMore()
				}
			} catch {
				print("error occurred.")
			}
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

		var shouldShowLoadMore = (bottomScrolledYPosition - scrollViewContentHeight + reloadDistance - loadMoreHeight + startResourceFetcherOffset) > 0
		shouldShowLoadMore = shouldShowLoadMore && needsToLoadMoreData
		return shouldShowLoadMore
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
}
