//
//  Spot.swift
//  GeocodingRenshu
//
//  Created by Rentaro on 2020/05/20.
//  Copyright © 2020 Rentaro. All rights reserved.
//

import UIKit
import CoreLocation

class Spot {
        
    let name: String
    let location: CLLocation
    
    init (_ lat: CLLocationDegrees, _ lng: CLLocationDegrees, _ name: String = "") {
        self.location = CLLocation(latitude: lat, longitude: lng)
        self.name = name
    }
    
    private(set) var distance: CLLocationDistance?
    
    var targetLocation: CLLocation? {
        didSet {
            guard let location = targetLocation else {
                distance = nil
                return
            }
            if location.isEqual(location: oldValue) {
                return
            }
            distance = self.location.distance(from: location)
        }
    }
    
}

extension Spot {
    
    static var list: [Spot] {
        return [
            Spot(34.98747669999999, 135.75949259999993, "京都タワー"),
            Spot(34.987578, 135.74722599999996, "京都水族館"),
            Spot(34.9811177, 135.74759640000002, "東寺"),
            Spot(34.9793536, 135.74259499999994, "羅城門跡"),
            Spot(34.9903771, 135.75109659999998, "西本願寺"),
            Spot(35.007345, 135.75443059999998, "本能寺"),
            Spot(35.0050538, 135.76329770000007, "錦市場"),
            Spot(35.1241, 135.82104500000003, "寂光院"),
            Spot(34.8892908, 135.80767830000002, "平等院"),
            Spot(34.892068, 135.81143900000006, "宇治上神社"),
            Spot(34.891048, 135.810701, "宇治神社"),
        ]
    }
    
    static func sortedList(nearFrom location: CLLocation) -> [Spot] {
        return self.list.sorted(by: { spot1, spot2 in
            spot1.targetLocation = location
            spot2.targetLocation = location
            return spot1.distance! < spot2.distance!
        })
    }
}

extension CLLocation {
    
    // 同じ座標かどうかを返す
    func isEqual(location: CLLocation?) -> Bool {
        if let location = location {
            return self.coordinate.latitude  == location.coordinate.latitude
                && self.coordinate.longitude == location.coordinate.longitude
        }
        return false
    }
}
