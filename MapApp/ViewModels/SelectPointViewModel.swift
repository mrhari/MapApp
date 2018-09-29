//
//  SelectPointViewModel.swift
//  MapApp
//
//  Created by Ngo Van Hai on 9/18/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import RxSwift

class SelectPointViewModel {
    var fromPoint = Variable<String>("")
    var toPoint = Variable<String>("")
    
    var canGo: Observable<Bool>{
        return Observable.combineLatest(fromPoint.asObservable(), toPoint.asObservable()) { from, to in
            from.count > 0 && to.count > 0
        }
    }
}
