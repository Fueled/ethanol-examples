//
//  DemoInformation.swift
//  EthanolExamples
//
//  Created by Stephane Copin on 7/2/15.
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
				return viewControllerClass.init() as! UIViewController
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
