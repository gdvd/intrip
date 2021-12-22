//
//  ViewControllerExchange.swift
//  intrip
//
//  Created by Gilles David on 19/12/2021.
//

import UIKit

class ViewControllerExchange: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let exchange = ModelExchange()
        
    }
    
    @IBOutlet weak var moneyIn: UITextField!
    @IBOutlet weak var moneyOut: UILabel!
    
    @IBAction func save(_ sender: UIButton) {
        //saveChecklistItems()
    }
    
    
    
}

