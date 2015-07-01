//
//  CategoryViewController.swift
//  EthanolExamples
//
//  Created by Stephane Copin on 7/1/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
//

import UIKit

enum Category {
  case UIComponents
}

class CategoryViewController: UITableViewController {
  private let ShowDemoListViewControllerSegueIdentifier = "ShowDemoListViewControllerSegueIdentifier"
  private let CategoryViewControllerTableViewCellIdentifier = "CategoryViewControllerTableViewCellIdentifier"
  
  private let categories: [(Category, String, demos: [DemoInformation])] = [
    (.UIComponents, "UI Components", [DemoInformation(name: "TextField", viewControllerClass: TextFieldViewController.self)])
  ]
  
  private var demosSelected: (String, Array<DemoInformation>)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CategoryViewControllerTableViewCellIdentifier)
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
