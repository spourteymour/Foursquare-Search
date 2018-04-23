//
//  ViewController.swift
//  Foursquare Places
//
//  Created by Sepandat Pourtaymour on 22/04/2018.
//  Copyright © 2018 Sepandat Pourtaymour. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class ViewController: UIViewController {

	@IBOutlet weak var searchTextField: UITextField!
	@IBOutlet weak var startButton: UIButton!
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		searchTextField.addTarget(self, action: #selector(textfieldChanged(textfield:)), for: .editingChanged)
		startButton.isEnabled = false
	}
	
	@IBAction func didTapStart(_ sender: Any) {
		let locationManager = LocationManager.instance
		locationManager.addDelegateForType(delegate: self, type: .userUpdate)
		locationManager.startUpdating()
		startButton.isEnabled = false
	}
	
	@objc func textfieldChanged(textfield: UITextField) {
		if let string = textfield.text, !string.isEmpty {
			startButton.isEnabled = true
		} else {
			startButton.isEnabled = false
		}
	}
}

extension ViewController: LocationOrganiserDelegate {
	func locationOrganiserDidUpdateUserLocation(location: CLLocation) {
		LocationManager.instance.removeDelegateForType(delegate: self, type: .userUpdate)
		let coordinate = location.coordinate
		guard let searchString = searchTextField.text else {return}
		FetchRequest.getVenues(query: searchString, coordinates: coordinate)
			.onSuccess { (response) in
				let venueTableVC = VenuesTableViewController()
				venueTableVC.venues = response.venues
				venueTableVC.title = searchString
				DispatchQueue.main.async {
					self.navigationController?.pushViewController(venueTableVC, animated: true)
				}
			}
			.onFailure { (error) in
				self.textfieldChanged(textfield: self.searchTextField)
		}
	}
}
