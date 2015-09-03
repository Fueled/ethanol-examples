//
//  ObjectHelpersExampleViewController.swift
//  EthanolExamples
//
//  Created by Bastien Falcou on 8/28/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
//

import UIKit
import EthanolUtilities

struct ObjectHelpersExampleViewControllerConstants {
  static let createViewString = "Create view"
  static let deallocViewString = "Dealloc view"
}

class ObjectHelpersExampleViewController: UIViewController {
  
  @IBOutlet weak var executeOnDeallocButton: UIButton!
  var viewToDealloc = UIView()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Object Helpers"
  }
  
  // MARK: Execute On Dealloc
  
  @IBAction func executeOnDeallocButtonTapped(sender: AnyObject) {
    if let text = executeOnDeallocButton.titleLabel?.text where text == ObjectHelpersExampleViewControllerConstants.createViewString {
      executeOnDeallocButton.setTitle(ObjectHelpersExampleViewControllerConstants.deallocViewString, forState: .Normal)
      viewToDealloc = UIView(frame: CGRect(x: executeOnDeallocButton.frame.origin.x + executeOnDeallocButton.frame.size.width + 20.0, y: executeOnDeallocButton.frame.origin.y, width: executeOnDeallocButton.frame.size.height, height: executeOnDeallocButton.frame.size.height))
      viewToDealloc.backgroundColor = UIColor.redColor()
      view.addSubview(viewToDealloc)
      
      viewToDealloc.eth_performBlockOnDealloc({ object in
        let alertController = UIAlertController(title: "View Deallocated", message: "The view has been deallocated", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        self.presentViewController(alertController, animated: true, completion: nil)
      })
    } else {
      executeOnDeallocButton.setTitle(ObjectHelpersExampleViewControllerConstants.createViewString, forState: .Normal)
      viewToDealloc.removeFromSuperview()
      viewToDealloc = UIView()  // Create a new view deallocs the previous one, and triggers our performBlockOnDealloc to be called.
    }
  }
  
  // MARK: Method Swizzling
  
  @IBAction func methodSwizzlingButtonTapped(sender: AnyObject) {
    let alertController = TestSwizzledAlertController(title: "This alert controller will be Swizzled", message: "This text is not going to be displayed because will be changed at runtime.", preferredStyle: .Alert)
    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
    alertController.addAction(defaultAction)
    
    print(alertController.description)
    
    self.presentViewController(alertController, animated: true, completion: nil)
  }
}

public class TestSwizzledAlertController: UIAlertController {
  
  override public class func initialize() {
    struct Static {
      static var token: dispatch_once_t = 0
    }
    
    // Make sure it is not a subclass
    if self !== TestSwizzledAlertController.self {
      return
    }
		
    TestSwizzledAlertController.eth_swizzleClassSelector(Selector("alertControllerWithTitle:message:preferredStyle:"), withSelector: Selector("eth_init:message:preferredStyle:"))
  }
  
  @objc public class func eth_init(title: String?, message: String?, preferredStyle: UIAlertControllerStyle) -> UIAlertController {
		return UIAlertController(title: "SWIZZLED", message: "The content of this message has been swizzled", preferredStyle: preferredStyle)
  }
}