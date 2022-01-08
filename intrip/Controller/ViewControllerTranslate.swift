//
//  ViewControllerTranslate.swift
//  intrip
//
//  Created by Gilles David on 19/12/2021.
//

import UIKit

class ViewControllerTranslate: UIViewController {

    @IBOutlet weak var textfieldIn: UITextField!
    @IBOutlet weak var textFieldOut: UITextField!
    
    @IBOutlet weak var pickerViewIn: UIPickerView!
    @IBOutlet weak var pickerViewOut: UIPickerView!
    
    @IBOutlet weak var buttonGetTranslate: UIButton!
    @IBOutlet weak var buttonReverse: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
        textfieldIn.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top
        textFieldOut.isUserInteractionEnabled = false
    }

    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func getTranslate(_ sender: UIButton) {
        if let textToTranslate = textfieldIn.text {
            print("getTranslate", textToTranslate)
        }
    }
    
    @IBAction func reverse(_ sender: UIButton) {
        print("reverse")
    }
    
    
    
}
