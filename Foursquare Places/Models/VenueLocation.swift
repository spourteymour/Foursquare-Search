//
//  File.swift
//  Foursquare Places
//
//  Created by Sepandat Pourtaymour on 22/04/2018.
//  Copyright © 2018 Sepandat Pourtaymour. All rights reserved.
//

import Foundation
import  CoreLocation

struct VenueLocation {
	let address: String?
	let coordinates: CLLocationCoordinate2D
	
	init(address: String?, coordinates: CLLocationCoordinate2D) {
		self.address = address
		self.coordinates = coordinates
	}
}

extension VenueLocation: Codable {
	enum VenueLocationKeys: String, CodingKey { // declaring our keys
		case address = "address"
		case lat = "lat"
		case long = "lng"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: VenueLocationKeys.self) // defining our (keyed) container
		let address: String? = try? container.decode(String.self, forKey: .address) // extracting the data
		let lat: Float = try container.decode(Float.self, forKey: .lat)
		let long: Float = try container.decode(Float.self, forKey: .long)
		let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
		
		self.init(address: address, coordinates: coordinates) // initializing our struct
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: VenueLocationKeys.self)
		try container.encode(address, forKey: .address)
		let lat = Float(coordinates.latitude)
		let long = Float(coordinates.longitude)
		try container.encode(long, forKey: .long)
		try container.encode(lat, forKey: .lat)
	}
}
