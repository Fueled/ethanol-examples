//
//  DemoListViewController.swift
//  EthanolExamples
//
//  Created by Stephane Copin on 7/1/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
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
