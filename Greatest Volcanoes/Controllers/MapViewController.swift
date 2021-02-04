//
//  MapViewController.swift
//  Greatest Volcanoes
//
//  Created by Игорь Растегаев on 27.01.2021.
//  Copyright © 2020 Daniil Marusenko. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var jsonManager = JSONManager()
    var coordinates: [[Double]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jsonManager.delegate = self
        jsonManager.getData(with: "https://stavigor.github.io/GVvolcanoes.json")
    }

}

//MARK: - JSONManagerDelegate

extension MapViewController: JSONManagerDelegate {
    
    func didUpdateData(_ jsonManager: JSONManager, data: [[String]]) {
        DispatchQueue.main.async {
            for volcano in data {
                if let lat = Double(volcano[1]), let lon = Double(volcano[2]) {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    annotation.title = volcano[0]
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
}
