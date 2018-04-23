//
//  Enums.swift
//  Foursquare Places
//
//  Created by Sepandat Pourtaymour on 22/04/2018.
//  Copyright © 2018 Sepandat Pourtaymour. All rights reserved.
//

import Foundation

enum HTTPType: String {
	case http
	case https
}

enum AppError: Error {
	case RequestFailed, NotFound
	case encodingError(errorDescription: String)
	case fetchError(errorDescription: String)
}

enum ImageDimension: Int {
	case small = 32
	case medium = 44
	case large = 64
	case xlarge = 88
}
