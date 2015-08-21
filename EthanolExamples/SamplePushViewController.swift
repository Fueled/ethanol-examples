//
//  SamplePushViewController.swift
//  EthanolExamples
//
//  Created by hhs-fueled on 19/08/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
//

import UIKit

class SamplePushViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "test"
    // Do any additional setup after loading the view.
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    print("current back button title \(self.navigationController?.eth_currentBackButtonTitle)")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
