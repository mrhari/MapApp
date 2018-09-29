//
//  NumberViewController.swift
//  MapApp
//
//  Created by Ngo Van Hai on 9/25/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NumberViewController: UIViewController {

    @IBOutlet weak var numberView: UILabel!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    var numberViewModel = NumberViewModel()
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        numberViewModel.number.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] number in
                self?.numberView.text = String(number)
                if number == 0 {
                    self?.downButton.isEnabled = false
                    self?.downButton.setTitleColor(.red, for: .disabled)
                } else {
                    self?.downButton.isEnabled = true
                    self?.downButton.setTitleColor(self?.upButton.titleLabel?.textColor, for: .normal)
                }
            }).disposed(by: dispose)
    }
    @IBAction func increaseClick(_ sender: Any) {
        numberViewModel.up()
    }
    @IBAction func decreaseClick(_ sender: Any) {
        numberViewModel.down()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
