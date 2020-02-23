//
//  Building.swift
//  BirdTest
//
//  Created by Danil Shchegol on 23.02.2020.
//  Copyright © 2020 Danil Shchegol. All rights reserved.
//

import RealmSwift

//class that is responsible for persistence of buildings' data in memory
final class Building: Object {
        
    let id = RealmOptional<Int>()
    let longitude = RealmOptional<Double>()
    let latitude = RealmOptional<Double>()
    
    @objc dynamic var name: String?
    @objc dynamic var address: String?
    @objc dynamic var imageURL: String?
           
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, name: String, address: String, longitude: Double, latitude: Double, imageURL: String) {
        self.init()
        self.id.value = id
        self.name = name
        self.address = address
        self.imageURL = imageURL
        self.longitude.value = longitude
        self.latitude.value = latitude
    }
}
