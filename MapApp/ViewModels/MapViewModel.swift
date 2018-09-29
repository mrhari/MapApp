//
//  MapViewModel.swift
//  MapApp
//
//  Created by Ngo Van Hai on 9/18/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import ObjectMapper
import GoogleMaps

class MapViewModel {
    
    let maxSpacePoint = 0.00015
    var currentLocation = Variable<Location>(Location(lat: 21.0573023, lng: 105.8236815))
    var polyLine = Variable<GMSPolyline>(GMSPolyline(path: GMSPath(fromEncodedPath: AppConstant.MapApi.polylineTest)))
    var isRuning = Variable<Bool>(false)
    var arrowPoints = Variable<[Location]>([])
    var points = [Location]()
    var currentPosition = 0
    var timer = Timer()
    var isComeBack = false
    
    init() {
        initData()
    }
    
    func initData() {
        
        let path = GMSPath(fromEncodedPath: isComeBack ? AppConstant.MapApi.polyComeBack : AppConstant.MapApi.polylineTest)
        let line = GMSPolyline(path: path)
        polyLine.value = line
        var arrowArray = [Location]()
        
        points.removeAll()
        currentPosition = 0
        
        for i in UInt(0)...(path?.count())! - 1 {
            points.append(Location(location: (path?.coordinate(at: i))!))
            if i.hashValue > 0 {
                let rotate: Double = getRotate(firstLocation: points[i.hashValue - 1], lastLocation: points[i.hashValue])
                points[i.hashValue - 1].rotate = rotate
            } else {
                currentLocation.value = points[0]
            }
            if i.hashValue % 16 == 0 {
                arrowArray.append(points[i.hashValue])
            }
        }
        splitPoint()
        arrowPoints.value = arrowArray
        
    }
    
    private func splitPoint() {
        if points.count < 2 {
            return
        }
        var i = 0
        while i < points.count - 2 {
           
            let spaceLat = abs(points[i + 1].lat! - points[i].lat!)
            let spaceLng = abs(points[i + 1].lng! - points[i].lng!)
            var countSplit = 1
            if spaceLat > maxSpacePoint && spaceLat > spaceLng{
                countSplit = Int(spaceLat/maxSpacePoint)
            }
            if spaceLng > maxSpacePoint && spaceLng > spaceLat{
                countSplit = Int(spaceLng/maxSpacePoint)
            }
            if countSplit == 1 {
                i += 1
                continue
            }
            let deltaLat = (points[i + 1].lat! - points[i].lat!)/Double(countSplit)
            let deltaLng = (points[i + 1].lng! - points[i].lng!)/Double(countSplit)
            for j in 1...countSplit {
                let location = Location(lat: points[i].lat! + deltaLat * Double(j), lng: points[i].lng! + deltaLng * Double(j),rotate: points[i].rotate)
                points.insert(location, at: i + j)
            }
            i += 1
        }
    }
    
    func run() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true, block: { _ in
            self.isRuning.value = true
            self.moving()
            })
        RunLoop.current.add(timer, forMode: .commonModes)
    }
    
    private func moving() {
        currentLocation.value = points[currentPosition]
        currentPosition += 1
        if currentPosition > points.count - 1 {
            timer.invalidate()
            currentPosition = 0
            isComeBack = !isComeBack
            self.isRuning.value = false
            initData()
        }
    }
    
    func getRotate(firstLocation: Location, lastLocation: Location) -> Double {
        let alphaLat = Double(firstLocation.lat! - lastLocation.lat!)
        let alphaLng  = Double(lastLocation.lng! - firstLocation.lng!)
        return atan2(alphaLat, alphaLng) * 180 / .pi + 90
    }
}


/*Alamofire.request(AppConstant.MapApi.apiDirection).responseJSON(completionHandler: { json in
    if let json = json.result.value {
        let reponse = Mapper<DirectionResponse>().map(JSONObject: json)
        print("ok")
    }
 })*/
