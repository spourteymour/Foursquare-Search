//
//  FetchRequest.swift
//  Foursquare Places
//
//  Created by Sepandat Pourtaymour on 22/04/2018.
//  Copyright © 2018 Sepandat Pourtaymour. All rights reserved.
//

import Foundation
import Alamofire
import BrightFutures
import CoreLocation

class FetchRequest {
	static func getVenues(query: String, coordinates: CLLocationCoordinate2D) -> Future<VenueFetchResponse, AppError> {
		let promise = Promise<VenueFetchResponse, AppError>()
		var startingParameters = [String: Any]()
		let latInt = Float(coordinates.latitude)
		let longInt = Float(coordinates.longitude)
		let coordinateString = "\(latInt),\(longInt)"
		startingParameters.updateValue(AppData.SquareInfo.clientId, forKey: "client_id")
		startingParameters.updateValue(AppData.SquareInfo.clientSecret, forKey: "client_secret")
		startingParameters.updateValue(coordinateString, forKey: "ll")
		startingParameters.updateValue("checkin", forKey: "intent")
		startingParameters.updateValue("400", forKey: "radius")
		startingParameters.updateValue(query, forKey: "query")
		startingParameters.updateValue("checkin", forKey: "intent")
		startingParameters.updateValue(AppData.SquareInfo.versionString, forKey: "v")
		
		Alamofire.request("https://api.foursquare.com/v2/venues/search", method: .post, parameters: startingParameters)
			.response { (response) in
				if let error = response.error {
					promise.failure(AppError.fetchError(errorDescription: "Fetch Error: \(error.localizedDescription)"))
					return
				}
				
				guard let responseData = response.data,
					let jsonData = FetchRequest.manipulateResponse(responseData: responseData),
					let result = try? JSONDecoder().decode(VenueFetchResponse.self, from: jsonData)
					else {
						promise.failure(AppError.fetchError(errorDescription: "Could Not Convert Venue Data"))
						return
				}
				promise.success(result)
			}
		return promise.future
	}
	
	static func manipulateResponse(responseData: Data) -> Data? {
		guard let jsonObject = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as! [String:Any] else {return nil}
		guard let dictionary = jsonObject["response"] as? [String: Any] else {return nil}
		return try? JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
	}

}
