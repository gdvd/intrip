//
//  ViewControllerExchange.swift
//  intrip
//
//  Created by Gilles David on 19/12/2021.
//

import UIKit

class ViewControllerExchange: UIViewController {
    
    @IBOutlet weak var moneyIn: UITextField!
    @IBOutlet weak var moneyOut: UITextField!
    
    @IBOutlet weak var currencyIn: UIPickerView!
    @IBOutlet weak var currencyOut: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let exchange = ModelExchange.shared
        exchange.getLastValues()
        
    }

    
}

