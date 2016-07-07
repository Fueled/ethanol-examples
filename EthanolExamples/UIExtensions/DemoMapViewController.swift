//
//  DemoMapViewController.swift
//  EthanolExamples
//
//  Created by Bastien Falcou on 8/26/15.
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
import MapKit
import EthanolUIExtensions

private let kNewYorkCityLatitude = 40.780247
private let kNewYorkCityLongitude = -73.971210
private let kAnimationDuration = 0.3

final class DemoMapViewController: UIViewController, MKMapViewDelegate {
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var zoomLevelTextField: UITextField!
	@IBOutlet weak var distanceMetersTextField: UITextField!
	@IBOutlet weak var ruler: UIView!
	@IBOutlet weak var rulerWidthConstraint: NSLayoutConstraint!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Demo MapView"
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		// Set initial zoom level
		zoomLevelTextField.text = "12"
		changeMapZoom()
		
		// Set initial number of meters to draw a line
		distanceMetersTextField.text = "500"
		drawRuler()
	}
	
	func changeMapZoom() {
		mapView.eth_setCenterCoordinate(CLLocationCoordinate2DMake(kNewYorkCityLatitude, kNewYorkCityLongitude), zoomLevel: UInt(zoomLevelTextField.text!)!, animated: true)
	}
	
	func drawRuler() {
		let numberFormatter = NSNumberFormatter()
		numberFormatter.numberStyle = .DecimalStyle
		let metersDistance = numberFormatter.numberFromString(distanceMetersTextField.text!)
		
		rulerWidthConstraint.constant = self.mapView.eth_sizeForDistanceInMeters(CGFloat(metersDistance!))
		UIView.animateWithDuration(kAnimationDuration) {
			self.view.layoutIfNeeded()
		}
	}
	
	// MARK: Event Methods
	
	@IBAction func didTapZoomLevelButton(sender: AnyObject) {
		changeMapZoom()
		drawRuler()
		view.endEditing(true)
	}
	
	@IBAction func didTapDistanceMetersButton(sender: AnyObject) {
		drawRuler()
		view.endEditing(true)
	}
	
	// MARK: MapView Delegate Methods
	
	func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
		drawRuler()
		zoomLevelTextField.text = String(mapView.eth_zoomLevel)
	}
}
