//
//  DemoMapViewController.swift
//  EthanolExamples
//
//  Created by Bastien Falcou on 8/26/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
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
