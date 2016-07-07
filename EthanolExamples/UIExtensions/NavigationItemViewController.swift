//
//  NavigationItemViewController.swift
//  EthanolExamples
//
//  Created by hhs-fueled on 17/08/15.
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
import EthanolUIExtensions

class NavigationItemViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupNavigationBar()
	}
	
	func setupNavigationBar(){
		self.navigationItem.setCustomBackButtonWithTitle("Custom", target:self, selector: #selector(backTapped))
  
		let attributedString = NSMutableAttributedString(string: "This is attributed title")
		
		var range = NSMakeRange(0, attributedString.length)
		attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGrayColor(), range:range)
		
		range = NSMakeRange(0, attributedString.length - 3)
		attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range:range)
		
		let font = UIFont(name: "AvenirNext-Regular", size: 22.0)!
		attributedString.addAttribute(NSFontAttributeName, value: font, range: range)
		self.navigationItem.attributedTitle = attributedString
	}
	
	func backTapped(){
		self.navigationController?.popViewControllerAnimated(true)
	}
}
