//
//  ViewController.swift
//  Unitrans
//
//  Created by Skyler Bala on 8/21/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapVC: UIViewController {

    var mapView: MKMapView!
    var lines: [Line]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        setViews()
    }

    func config() {
        mapView = MKMapView()
        mapView.delegate = self
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.mapType = MKMapType.standard
    }
    
    func setViews() {
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: topbarHeight)
        ])
    }
}

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            
        }
        else if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.orange
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer()
    }
}

