//
//  ViewController.swift
//  MapApp
//
//  Created by Ngo Van Hai on 9/18/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SelectPointViewController: UIViewController {

    @IBOutlet weak var fromInputView: UITextField!
    @IBOutlet weak var toInputView: UITextField!
    @IBOutlet weak var goButtonView: UIButton!
    var selectPointViewModel = SelectPointViewModel()
    let dispose = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    func setViews() {
        _ = fromInputView.rx.text.map({$0 ?? ""}).bind(to: selectPointViewModel.fromPoint).disposed(by: dispose)
        _ = toInputView.rx.text.map({$0 ?? ""}).bind(to: selectPointViewModel.toPoint).disposed(by: dispose)
        _ = selectPointViewModel.canGo.asObservable().subscribe(onNext: {[weak self] isEnable in
            self?.goButtonView.isEnabled = isEnable
            self?.goButtonView.alpha = isEnable ? 1 : 0.5
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dispose)
    }
    
    @IBAction func goAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mapController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
//        mapController.fromPoint = fromInputView.text ?? ""
//        mapController.toPoint = toInputView.text ?? ""
        self.present(mapController, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

