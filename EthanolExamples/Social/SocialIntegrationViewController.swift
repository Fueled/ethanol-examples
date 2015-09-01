//
//  SocialIntegrationViewController.swift
//  EthanolExamples
//
//  Created by svs-fueled on 01/09/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
//

import Foundation
import EthanolSocial

class SocialIntegrationViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let loginButton = UIButton(type: .Custom)
    loginButton.setTitle("Login", forState: .Normal)
    loginButton.frame = self.view.frame
    loginButton.addTarget(self, action: "loginTapped:", forControlEvents: .TouchUpInside)
    self.view.addSubview(loginButton)
  }

  func loginTapped(sender:AnyObject) {
    SocialManager.serviceForType(serviceType: .Facebook).loginSilentlyIfPossible(permissions: ["public_profile", "email"], success: { (success) in
      print("Success : \(success)")
      print("user is : \(SocialManager.serviceForType(serviceType: .Facebook).currentUser)")
      }, failure: { (error) in
        print("error: \(error)")
    })
  }

}