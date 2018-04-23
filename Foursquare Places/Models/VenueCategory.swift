//
//  VenueCategory.swift
//  Foursquare Places
//
//  Created by Sepandat Pourtaymour on 22/04/2018.
//  Copyright © 2018 Sepandat Pourtaymour. All rights reserved.
//

import Foundation

struct VenueCategory {
	let name: String
	let icon: CategoryIcon
	
	init(name: String, icon: CategoryIcon) {
		self.name = name
		self.icon = icon
	}
}

extension VenueCategory: Codable {
	enum VenueCategoryKeys: String, CodingKey { // declaring our keys
		case name = "name"
		case icon = "icon"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: VenueCategoryKeys.self) // defining our (keyed) container
		let name: String = try container.decode(String.self, forKey: .name) // extracting the data
		let iconString: [String: String] = try container.decode([String: String].self, forKey: .icon) // extracting the data
		guard let prefix = iconString["prefix"], let suffix = iconString["suffix"] else { throw AppError.fetchError(errorDescription: "Error Decoding VenueCategory with name: \(name)")}
		let categoryIcon = CategoryIcon(prefix: prefix, suffix: suffix, dimension: .medium)
		self.init(name: name, icon: categoryIcon) // initializing our struct
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: VenueCategoryKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(icon.dictionary(), forKey: .name)
	}
}
