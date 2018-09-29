//
//  Step.swift
//  MapApp
//
//  Created by Ngo Van Hai on 9/18/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import ObjectMapper

class Step: Mappable {
    
    var distance: Item?
    var duration: Item?
    var startLocation: Location?
    var endLocation: Location?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        distance <- map["distance"]
        duration <- map["duration"]
        startLocation <- map["start_location"]
        endLocation <- map["end_location"]
    }
}
