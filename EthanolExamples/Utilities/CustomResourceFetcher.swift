//
//  CustomResourceFetcher.swift
//  EthanolExamples
//
//  Created by hhs-fueled on 14/09/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
//

import UIKit
import EthanolUtilities

class CustomResourceFetcher: ResourceFetcher {
	var delayTime = 2.0
	var lastPageNumer = 5
	var successChance = 100 // percent success chance

	override func fetchPage(pageNumber: Int, pageLimit: Int, completion: ExternalAPICompletionHandler?) {

		UIApplication.sharedApplication().networkActivityIndicatorVisible = true // Beginning Network activity

		let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(delayTime * Double(NSEC_PER_SEC)))
		dispatch_after(delay, dispatch_get_main_queue()) {
			var randomArray: [String] = []

			if (pageNumber == self.lastPageNumer) { // Last Page
				for index in 0..<pageLimit-1 {
					randomArray.append("Page - \(pageNumber) - \(index)")
				}
			} else {
				for index in 0..<pageLimit {
					randomArray.append("Page - \(pageNumber) - \(index)")
				}
			}

			let error = NSError(domain: "APIERROR", code: 400, userInfo: [NSLocalizedDescriptionKey : "NOTHING ERROR"])

			let success = (random() % 100 <= self.successChance)

			UIApplication.sharedApplication().networkActivityIndicatorVisible = false // Ended Network Activity
			if success {
				print("Fetched Page : \(pageNumber)")
				completion?(){ return randomArray }
			} else {
				completion?(){ throw error }
			}
		}
	}

}



