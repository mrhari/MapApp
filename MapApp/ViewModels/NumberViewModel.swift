//
//  NumberViewModel.swift
//  MapApp
//
//  Created by Ngo Van Hai on 9/25/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import RxSwift

class NumberViewModel {
    
    var number = Variable<Int>(10)
    
    func up() {
        number.value = number.value + 2
    }
    
    func down() {
        if number.value == 0 {
            return
        }
        number.value = number.value - 1
    }
    
    public func clear() {
        number.value = 0
    }
}
