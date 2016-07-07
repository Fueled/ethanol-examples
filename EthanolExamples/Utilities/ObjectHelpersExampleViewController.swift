//
//  ObjectHelpersExampleViewController.swift
//  EthanolExamples
//
//  Created by Bastien Falcou on 8/28/15.
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
    if let text = self.executeOnDeallocButton.titleLabel?.text where text == ObjectHelpersExampleViewControllerConstants.createViewString {
      self.executeOnDeallocButton.setTitle(ObjectHelpersExampleViewControllerConstants.deallocViewString, forState: .Normal)
      self.viewToDealloc = UIView(frame: CGRect(x: self.executeOnDeallocButton.frame.origin.x + self.executeOnDeallocButton.frame.size.width + 20.0, y: self.executeOnDeallocButton.frame.origin.y, width: self.executeOnDeallocButton.frame.size.height, height: self.executeOnDeallocButton.frame.size.height))
      self.viewToDealloc.backgroundColor = UIColor.redColor()
      view.addSubview(viewToDealloc)
      
      self.viewToDealloc.eth_performBlockOnDealloc({ object in
        let alertController = UIAlertController(title: "View Deallocated", message: "The view has been deallocated", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        self.presentViewController(alertController, animated: true, completion: nil)
      })
    } else {
      self.executeOnDeallocButton.setTitle(ObjectHelpersExampleViewControllerConstants.createViewString, forState: .Normal)
      self.viewToDealloc.removeFromSuperview()
      self.viewToDealloc = UIView()  // Create a new view deallocs the previous one, and triggers our performBlockOnDealloc to be called.
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
		
    TestSwizzledAlertController.eth_swizzleClassSelector(#selector(UIAlertController.init(title:message:preferredStyle:)), withSelector: #selector(TestSwizzledAlertController.eth_init(_:message:preferredStyle:)))
  }
  
  @objc public class func eth_init(title: String?, message: String?, preferredStyle: UIAlertControllerStyle) -> UIAlertController {
		return UIAlertController(title: "SWIZZLED", message: "The content of this message has been swizzled", preferredStyle: preferredStyle)
  }
}
