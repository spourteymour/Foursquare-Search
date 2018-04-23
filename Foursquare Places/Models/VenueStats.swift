//
//  VenueStats.swift
//  Foursquare Places
//
//  Created by Sepandat Pourtaymour on 22/04/2018.
//  Copyright © 2018 Sepandat Pourtaymour. All rights reserved.
//

import Foundation

struct VenueStats {
	let tipCount: Int
	let userCount: Int
	let checkinCount: Int
	
	init(tipCount: Int, userCount: Int, checkinCount: Int) {
		self.tipCount = tipCount
		self.userCount = userCount
		self.checkinCount = checkinCount
	}
}

extension VenueStats: Codable {
	enum VenueStatsKeys: String, CodingKey { // declaring our keys
		case stats = "stats"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: VenueStatsKeys.self) // defining our (keyed) container
		let statsDict: [String: Int] = try container.decode([String: Int].self, forKey: .stats) // extracting the data
		guard let tipCount = statsDict["tipCount"],
			let usersCount = statsDict["usersCount"],
			let checkins = statsDict["checkinsCount"] else {
				throw AppError.encodingError(errorDescription: "Could not get venue stats")
		}
		
		self.init(tipCount: tipCount, userCount: usersCount, checkinCount: checkins) // initializing our struct
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: VenueStatsKeys.self)
		var encodingDict = [String: Int]()
		encodingDict.updateValue(tipCount, forKey: "tipCount")
		encodingDict.updateValue(checkinCount, forKey: "checkinsCount")
		encodingDict.updateValue(userCount, forKey: "usersCount")
		try container.encode(encodingDict, forKey: VenueStatsKeys.stats)
	}
}
