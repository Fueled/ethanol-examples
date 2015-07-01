//
//  DemoInformation.swift
//  EthanolExamples
//
//  Created by Stephane Copin on 7/2/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
//

import Foundation

class DemoInformation {
  private let viewControllerClass: NSObject.Type?
  private let viewControllerBuilder: (() -> UIViewController)?
  let name: String
  
  var viewController: UIViewController {
    get {
      if let viewControllerBuilder = self.viewControllerBuilder {
        return viewControllerBuilder()
      }
      if let viewControllerClass = self.viewControllerClass {
        return viewControllerClass.alloc().dynamicType.init() as! UIViewController
      }
      
      return UIViewController()
    }
  }
  
  init(name: String, viewControllerClass: NSObject.Type) {
    self.name = name
    self.viewControllerClass = viewControllerClass
    self.viewControllerBuilder = nil
  }
  
  init(name: String, viewControllerBuilder: () -> UIViewController) {
    self.name = name
    self.viewControllerClass = nil
    self.viewControllerBuilder = viewControllerBuilder
  }
}
