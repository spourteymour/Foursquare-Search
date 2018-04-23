//
//  Extensions.swift
//  Foursquare Places
//
//  Created by Sepandat Pourtaymour on 22/04/2018.
//  Copyright © 2018 Sepandat Pourtaymour. All rights reserved.
//

import Foundation

class AppData {
	class SquareInfo {
		static var versionString: String {
			let formatter = DateFormatter()
			formatter.dateFormat = "YYYYMMDD"
			
			return formatter.string(from: Date())
		}
		
		static let clientSecret = "A5IJRQ2GFDSNTUH2SD2I1J13DXGH53WGYVQWKYMUH1IGJ3A1"
		static let clientId = "TI0S2MJVE0XTKOOF3TQ1OUATAZCGZS0WPGP5VVPZ5DEGHJPE"
	}
}
extension Date {
}
