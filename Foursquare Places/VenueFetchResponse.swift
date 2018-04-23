//
//  FetchResponse.swift
//  Foursquare Places
//
//  Created by Sepandat Pourtaymour on 22/04/2018.
//  Copyright © 2018 Sepandat Pourtaymour. All rights reserved.
//

import Foundation

struct VenueFetchResponse {
	let venues: [Venue]
	
	init(venues: [Venue]) {
		self.venues = venues
	}
}

extension VenueFetchResponse: Codable {
	enum VenueFetchResponseKeys: String, CodingKey { // declaring our keys
		case venues = "venues"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: VenueFetchResponseKeys.self) // defining our (keyed) container
		let venues: [Venue] = try container.decode([Venue].self, forKey: .venues) // extracting the data

		self.init(venues: venues) // initializing our struct
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: VenueFetchResponseKeys.self)
		try container.encode(venues, forKey: .venues)
	}
}
