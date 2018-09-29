//
//  DirectionResponse.swift
//  MapApp
//
//  Created by Ngo Van Hai on 9/18/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import ObjectMapper

class DirectionResponse: Mappable {
    
    var routes: [Route]?
    var status: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        routes <- map["routes"]
        status <- map["status"]
    }
    
    
}
