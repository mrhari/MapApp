//
//  Route.swift
//  MapApp
//
//  Created by Ngo Van Hai on 9/18/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import ObjectMapper

class Route: Mappable {
    
    var legs: [Leg]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        legs <- map["legs"]
    }
    
    
}
