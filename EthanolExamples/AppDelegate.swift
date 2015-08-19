//
//  AppDelegate.swift
//  EthanolExamples
//
//  Created by Stephane Copin on 7/1/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
//

import UIKit
import EthanolTools

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    let timer2 = ETHPausableTimer(timeInterval: 5.0, block: { (timer) -> Void in
      // Code executed once done.
      NSLog("\(timer.timeInterval)")
    }, paused: true)
    
    // Start timer.
    // At that point, timeInterval is still equal to 5. We also keep track of the time.
    NSLog("\(timer2.timeInterval)")
    
    timer2.resume()
    // Start timer.
    // At that point, timeInterval is still equal to 5. We also keep track of the time.
    NSLog("\(timer2.timeInterval)")
    
    // Pause timer after 2.5 seconds
    // timeInterval value has been updated accordingly. We can see comparing times that 2.5 seconds elapsed.
    usleep(2500000)
    timer2.pause()
    NSLog("\(timer2.timeInterval)")
    
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

