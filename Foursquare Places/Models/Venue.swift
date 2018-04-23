//
//  Venue.swift
//  Foursquare Places
//
//  Created by Sepandat Pourtaymour on 22/04/2018.
//  Copyright © 2018 Sepandat Pourtaymour. All rights reserved.
//

import Foundation

struct Venue {
	let name: String
	let location: VenueLocation
	let categories: [VenueCategory]
	
	init(name: String, location: VenueLocation, categories: [VenueCategory]) {
		self.name = name
		self.location = location
		self.categories = categories
	}
}

extension Venue: Codable {
	enum VenueKeys: String, CodingKey { // declaring our keys
		case name = "name"
		case location = "location"
		case categories = "categories"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: VenueKeys.self) // defining our (keyed) container
		let name: String = try container.decode(String.self, forKey: .name) // extracting the data
		let location: VenueLocation = try container.decode(VenueLocation.self, forKey: .location) // extracting the data
		let categories: [VenueCategory] = try container.decode([VenueCategory].self, forKey: .categories) // extracting the data

		self.init(name: name, location: location, categories: categories) // initializing our struct
}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: VenueKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(location, forKey: .location)
		try container.encode(categories, forKey: .categories)
	}
}
