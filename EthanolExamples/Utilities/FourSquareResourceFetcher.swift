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
	override func fetchPage(pageNumber: Int, pageLimit: Int, completion: ExternalAPICompletionHandler?) {
		let delayTime = 2.0
		delay(delayTime) { () -> () in
			var randomArray: [String] = []
			for index in 0..<pageLimit {
				randomArray.append("Page - \(pageNumber) - \(index)")
			}

			let error = NSError(domain: "APIERROR", code: 400, userInfo: [NSLocalizedDescriptionKey : "NOTHING ERROR"])

			let successChance = 90 // percent success chance
			let success = (random() % 100 <= successChance)

			if success {
				completion?(){ return randomArray }
			} else {
				completion?(){ throw error }
			}
		}
		
	}
}
