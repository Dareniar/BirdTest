//
//  BuildingAnnotation.swift
//  BirdTest
//
//  Created by Danil Shchegol on 23.02.2020.
//  Copyright © 2020 Danil Shchegol. All rights reserved.
//

import MapKit

//class that is responsible for showing buildings' info on map
final class BuildingAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var name: String?
    var address: String?
    var imageURL: String?
    
    init?(building: Building) {
        guard let latitude = building.latitude.value, let longitude = building.longitude.value else { return nil }
        self.name = building.name
        self.address = building.address
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.imageURL = building.imageURL
    }
}
