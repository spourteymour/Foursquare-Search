//
//  VenuesTableViewController.swift
//  Foursquare Places
//
//  Created by Sepandat Pourtaymour on 23/04/2018.
//  Copyright © 2018 Sepandat Pourtaymour. All rights reserved.
//

import UIKit
import Kingfisher

fileprivate let venueCellId = "venueCellId"

class VenuesTableViewController: UITableViewController {

	var venues = [Venue]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		registerCell()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		tableView.reloadData()
	}
	
	func registerCell() {
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: venueCellId)
	}

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return venues.count
    }

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let venue = venues[indexPath.row]
		let category = venue.categories.first?.name
		let messageString = "Category:\n\(category ?? "NA")"
		let alertVC = UIAlertController(title: venue.name, message: messageString, preferredStyle: .alert)
		alertVC.addAction(UIAlertAction(title: "Continue", style: .default))
		DispatchQueue.main.async {
			self.present(alertVC, animated: true)
		}
	}
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: venueCellId, for: indexPath)
		cell.selectionStyle = .none
		cell.imageView?.backgroundColor = .lightGray
		cell.imageView?.layer.cornerRadius = 22
		cell.imageView?.layer.masksToBounds = true

		configure(cell: cell, indexPath: indexPath)
		
        return cell
    }
	
	func configure(cell: UITableViewCell, indexPath: IndexPath) {
		let venue = venues[indexPath.row]
		let url = venue.categories.first?.icon.url
		cell.imageView?.kf.setImage(with: url)
		cell.textLabel?.text = venue.name
	}
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		configure(cell: cell, indexPath: indexPath)
	}
}
