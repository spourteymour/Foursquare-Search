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
	let location: Location
	let categories: [VenueCategory]
	let stats: VenueStats
	
	init(name: String, location: Location, categories: [VenueCategory], stats: VenueStats) {
		self.name = name
		self.location = location
		self.categories = categories
		self.stats = stats
	}
}

extension Venue: Codable {
	enum VenueKeys: String, CodingKey { // declaring our keys
		case name = "name"
		case location = "location"
		case categories = "categories"
		case stats = "stats"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: VenueKeys.self) // defining our (keyed) container
		let name: String = try container.decode(String.self, forKey: .name) // extracting the data
		let location: Location = try container.decode(Location.self, forKey: .location) // extracting the data
		let categories: [VenueCategory] = try container.decode([VenueCategory].self, forKey: .categories) // extracting the data
		let stats: VenueStats = try container.decode(VenueStats.self, forKey: .stats) // extracting the data

		self.init(name: name, location: location, categories: categories, stats: stats) // initializing our struct
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: VenueKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(location, forKey: .location)
		try container.encode(categories, forKey: .categories)
		try container.encode(stats, forKey: .stats)
	}
}
