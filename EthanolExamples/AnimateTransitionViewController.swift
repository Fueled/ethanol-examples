//
//  AnimateTransitionViewController.swift
//  EthanolExamples
//
//  Created by hhs-fueled on 18/08/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
//

import UIKit

class AnimateTransitionViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.title = "Animate"
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func pushWithAnimationTapped(sender: AnyObject) {
    let viewController = SamplePushViewController()
    self.navigationController?.eth_animatedTransitionToViewController(viewController, transitionOption: UIViewAnimationOptions.TransitionFlipFromRight, completionHandler: { (Bool finished) -> Void in
      
    })
    
  }
  
}
