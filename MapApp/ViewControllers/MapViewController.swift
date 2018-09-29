//
//  MapViewController.swift
//  MapApp
//
//  Created by Ngo Van Hai on 9/18/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import UIKit
import GoogleMaps
import RxSwift
import RxCocoa

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var runButton: UIButton!
    
    var mapViewModel = MapViewModel()
    let dispose = DisposeBag()
    let zoom: Float = 17.0
    var time = Timer()
    
    let marker = GMSMarker()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    func setViews() {
        
        let camera = GMSCameraPosition.camera(withLatitude: 21.006771, longitude: 105.787829, zoom: zoom)
        mapView.camera = camera
        
        marker.icon = #imageLiteral(resourceName: "icon_car")
        marker.map = mapView
        marker.appearAnimation = .pop
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        marker.isFlat = true
        
        mapViewModel.polyLine.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] line in
                line.strokeColor = (self?.mapViewModel.isComeBack)! ? .magenta : .green
                line.strokeWidth = 3
                line.map = self?.mapView
            }).disposed(by: dispose)
      
        mapViewModel.currentLocation.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] location in
                self?.marker.position = location.getLocation()
                self?.marker.rotation = location.rotate
                self?.marker.map = self?.mapView
                self?.updateCamera(location: location)
            }).disposed(by: dispose)
        
        mapViewModel.isRuning.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] isRuning in
                self?.runButton.isEnabled = !isRuning
                self?.runButton.setTitle((self?.mapViewModel.isComeBack)! ? "Come Back Home" : "Run Now", for: .normal)
            }).disposed(by: dispose)
        
        mapViewModel.arrowPoints.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] locations in
                self?.drawArrow(points: locations)
            }).disposed(by: dispose)
    }
    
    func drawArrow(points: [Location]) {
        for location in points {
            let marker = GMSMarker(position: location.getLocation())
            marker.icon = mapViewModel.isComeBack ? #imageLiteral(resourceName: "arrow_red") : #imageLiteral(resourceName: "arrow_blue")
            marker.rotation = location.rotate
            marker.zIndex = -100
            marker.map = self.mapView
        }
    }
    
    @IBAction func run(_ sender: Any) {
        mapViewModel.run()
    }
    
    func updateCamera(location: Location) {
        let camera = GMSCameraPosition.camera(withTarget: location.getLocation(), zoom: zoom)
        self.mapView?.animate(to: camera)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

