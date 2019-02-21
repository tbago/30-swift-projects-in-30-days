//
//  ViewController.swift
//  FindMyPosition
//
//  Created by tbago on 2019/2/21.
//  Copyright © 2019年 tbago. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var locationInfoLabel: UILabel!
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case  .restricted, .denied:
                print("User not allow access")
            case .authorizedAlways, .authorizedWhenInUse:
                print("access")
            }
        } else {
            print("Location services are not enabled")
        }
    }

    @IBAction func findMyLocationButtonClick() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locations = locations as NSArray
        let currentLocation = locations.lastObject as! CLLocation
        let corrdinateString = "latitude:\(currentLocation.coordinate.latitude) longitude:\(currentLocation.coordinate.longitude)"
        print(corrdinateString)
        
        reverseGeocode(location:currentLocation)
        
        locationManager.stopUpdatingLocation()
    }
    
    func reverseGeocode(location:CLLocation) {
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if (error != nil) {
                print("reverse geocode location failed " + error!.localizedDescription)
                return
            }
            
            let tempArray = placemarks! as NSArray
            let placemark = tempArray.firstObject as! CLPlacemark
            let address = "\(placemark.thoroughfare!),\(placemark.locality!),\(placemark.country!)"
            
            self.locationInfoLabel.text = address
        }
    }
    
}

