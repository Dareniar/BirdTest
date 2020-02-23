//
//  ViewController.swift
//  BirdTest
//
//  Created by Danil Shchegol on 23.02.2020.
//  Copyright © 2020 Danil Shchegol. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    //variable for setting initial map region
    private let kyivRegion: MKCoordinateRegion = {
        let location = CLLocationCoordinate2DMake(50.45, 30.523333)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        return MKCoordinateRegion(center: location, span: span)
    }()

    //converting realm objects into annotation
    private let annotations: [BuildingAnnotation] = RealmManager.default.objects(Building.self)
        .compactMap { BuildingAnnotation(building: $0) }
    
    private let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)

        mapView.frame = self.view.bounds
        mapView.delegate = self
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "building")
        mapView.addAnnotations(annotations)
        mapView.setRegion(kyivRegion, animated: false)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? BuildingAnnotation,
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: "building") as? MKMarkerAnnotationView {
            view.canShowCallout = true
            //configuring appearance of annotation
            view.glyphImage = UIImage(named: "building")
            view.markerTintColor = .orange
            view.detailCalloutAccessoryView = CalloutView(annotation: annotation)
            return view
        } else {
            return nil
        }
    }
}

