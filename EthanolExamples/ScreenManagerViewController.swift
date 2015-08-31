//
//  screenManagerViewController.swift
//  EthanolExamples
//
//  Created by Bastien Falcou on 8/31/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
//

import UIKit
import EthanolTools
import EthanolUtilities

class ScreenManagerViewController: UIViewController {
  
  var screenManager: ETHScreenManager!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    screenManager = ETHScreenManager(screenStatus: UIApplication.sharedApplication().applicationState == .Active ? .On : .Unknown)
    screenManager.startUpdatingScreenStatus()
  }
  
  @IBAction func didTapNotificationButton(sender: AnyObject) {
    delay(5.0) {
      ETHScreenManager.wakeUpScreenWithMessage("I am a local Push Notification!")
    }
  }
  
  @IBAction func didTapWakeScreenUpButton(sender: AnyObject) {
    delay(5.0) {
      ETHScreenManager.wakeUpScreen()
    }
  }
}
