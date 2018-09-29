//
//  Distance.swift
//  MapApp
//
//  Created by Ngo Van Hai on 9/18/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import ObjectMapper

class Item: Mappable {
    
    var text: String?
    var value: Int32?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        text <- map["text"]
        value <- map["value"]
    }
    
}
