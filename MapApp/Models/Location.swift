//
//  Location.swift
//  MapApp
//
//  Created by Ngo Van Hai on 9/18/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import ObjectMapper
import GoogleMaps

class Location: Mappable {
    
    var lat: Double?
    var lng: Double?
    var rotate : Double = 0
    var isAdd = false
    
    init(lat: Double, lng:Double) {
        self.lat = lat
        self.lng = lng
    }
    
    init(lat: Double, lng: Double, rotate: Double) {
        self.lat = lat
        self.lng = lng
        self.rotate = rotate
        isAdd = true
    }
    
    init(location: CLLocationCoordinate2D) {
        self.lat = location.latitude
        self.lng = location.longitude
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["lng"]
    }
    
    func getLocation() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
    }
    
}
