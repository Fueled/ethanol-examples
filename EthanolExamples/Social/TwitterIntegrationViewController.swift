//
//  SocialIntegrationViewController.swift
//  EthanolExamples
//
//  Created by svs-fueled on 01/09/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
//

import Foundation
import EthanolSocial

class TwitterIntegrationViewController: UIViewController {

	@IBAction func loginTapped(sender: AnyObject) {
		SocialManager.serviceForType(serviceType: .Twitter).loginSilentlyIfPossible(success: { (success) in
			print("Success : \(success)")
			print("user is : \(SocialManager.serviceForType(serviceType: .Twitter).currentUser?.socialServiceDescription)")
			}, failure: { (error) in
				print("error: \(error)")
		})
	}
}