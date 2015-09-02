//
//  SocialIntegrationViewController.swift
//  EthanolExamples
//
//  Created by svs-fueled on 01/09/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
//

import Foundation
import EthanolSocial

class FacebookIntegrationViewController: UIViewController {

	@IBAction func loginTapped(sender: AnyObject) {
    SocialManager.serviceForType(serviceType: .Facebook).loginSilentlyIfPossible(permissions: [FacebookSocialServicePermission.PublicProfile, FacebookSocialServicePermission.Email], success: { (success) in
      print("Success : \(success)")
      print("user is : \(SocialManager.serviceForType(serviceType: .Facebook).currentUser?.socialServiceDescription)")
      }, failure: { (error) in
        print("error: \(error)")
    })
  }
}

class TwitterIntegrationViewController: UIViewController {

	@IBAction func loginTapped(sender: AnyObject) {
		SocialManager.serviceForType(serviceType: .Twitter).loginSilentlyIfPossible(permissions: ["public_profile", "email"], success: { (success) in
			print("Success : \(success)")
			print("user is : \(SocialManager.serviceForType(serviceType: .Twitter).currentUser?.socialServiceDescription)")
			}, failure: { (error) in
				print("error: \(error)")
		})
	}
}