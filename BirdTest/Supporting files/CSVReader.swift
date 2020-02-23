//
//  CSVReader.swift
//  BirdTest
//
//  Created by Danil Shchegol on 23.02.2020.
//  Copyright © 2020 Danil Shchegol. All rights reserved.
//

import Foundation

final class CSVReader {
    
    static let shared = CSVReader()
    
    private init() {}
    
    func readBuildings(from fileName: String) {
        //location of csv-file
        guard let path = Bundle.main.path(forResource: fileName, ofType: "csv") else { return }
        
        do {
            let csvString = try String(contentsOfFile: path) //writing contents of file into string-variable
            //converting String into [[String]]
            let csvParsed = csvString.components(separatedBy: "\n").map { $0.components(separatedBy: ";") }
            var buildings: [Building] = [Building]()
            for i in 1...(csvParsed.count - 1) { //skipping line 0 of csv-file
                
                let buildingString = csvParsed[i]
                guard buildingString.count == 6, //checking that every line has 6 columns even if it is empty
                    let id = Int(buildingString[0]),
                    let latitude = Double(buildingString[3]),
                    let longitude = Double(buildingString[4]) else { continue } //every building must have id and coordinates
                
                let name = buildingString[1].replacingOccurrences(of: "\"", with: "")
                let address = buildingString[2].replacingOccurrences(of: "\"", with: "")
                let imageURL = buildingString[5]
                //convert array of strings into Realm object
                buildings.append(Building(id: id, name: name, address: address, longitude: longitude, latitude: latitude, imageURL: imageURL))
            }
            //adding content of csv to Realm
            RealmManager.add(objects: buildings)
        } catch {
            print(error)
        }
    }
}
