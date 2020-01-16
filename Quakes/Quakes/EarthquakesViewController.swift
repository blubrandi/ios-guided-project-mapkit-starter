//
//  EarthquakesViewController.swift
//  Quakes
//
//  Created by Paul Solt on 10/3/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit
import MapKit

class EarthquakesViewController: UIViewController {
    
    lazy private var quakeFetcher = QuakeFetcher()
		
	// NOTE: You need to import MapKit to link to MKMapView
	@IBOutlet var mapView: MKMapView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuakes()
    }
    private func fetchQuakes() {
        quakeFetcher.fetchQuakes { (quakes, error) in
            if let error = error {
                print("Error: \(error)")
            }
            
            if let quakes = quakes {
                print(quakes.count)
                
                DispatchQueue.main.async {
                    self.mapView.addAnnotations(quakes)
                    
                    //set region for the map.  We're grabbing the first returned earthquake from the api, and then set that as our map region
                    
                    guard let quake = quakes.first else { return }
                    
                    //create coordinate span
                    let span = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
                    
                    // create region, takes the coord span and the center coord
                    let region = MKCoordinateRegion(center: quake.coordinate, span: span)
                    
                    //set on map
                    self.mapView.setRegion(region, animated: true)
                    
                }
            }
        }
    }
}
