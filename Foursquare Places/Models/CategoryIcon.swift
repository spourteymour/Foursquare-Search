//
//  CategoryIcon.swift
//  Foursquare Places
//
//  Created by Sepandat Pourtaymour on 23/04/2018.
//  Copyright © 2018 Sepandat Pourtaymour. All rights reserved.
//

import Foundation

struct CategoryIcon {
	fileprivate let prefix: String
	fileprivate let suffix: String
	fileprivate var urlString: String
	var url: URL? {
		return URL(string: urlString)
	}
	
	init(prefix:String, suffix: String, dimension: ImageDimension) {
		self.prefix = prefix
		self.suffix = suffix
		self.urlString = "\(prefix)\(String(dimension.rawValue))\(suffix)"
	}
	
	func dictionary() -> [String: String] {
		var toRet = [String: String]()
		toRet.updateValue(prefix, forKey: "prefix")
		toRet.updateValue(suffix, forKey: "suffix")
		return toRet
	}
}
