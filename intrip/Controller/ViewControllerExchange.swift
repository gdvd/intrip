//
//  ViewControllerExchange.swift
//  intrip
//
//  Created by Gilles David on 19/12/2021.
//

import UIKit

class ViewControllerExchange: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var moneyIn: UITextField!
    @IBOutlet weak var moneyOut: UITextField!
    @IBOutlet weak var currencyPickerViewIn: UIPickerView!
    @IBOutlet weak var currencyPickerViewOut: UIPickerView!
    @IBOutlet weak var msg: UILabel!
    @IBOutlet var viewExchange: UIView!
    

    private var exchange: ModelExchange!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
        
        exchange = ModelExchange.shared
        exchange.getLastValues(callback: { 
            response in
            self.resetValues()
            switch response {
            case .Success:
                self.updateData(msg: "")
                self.setupPickerviewsWithDefaultValues()
            case .OldValues(date: let date):
                self.updateData(msg: "Old values : " + date)
                self.setupPickerviewsWithDefaultValues()
            case .Failure(failure: let failure):
                self.showError(msg: failure.localizedDescription)
            }
        })
    }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
    
    private func showError(msg: String){
        DispatchQueue.main.async { 
            self.msg.text = msg
        }
        let alertVC = UIAlertController(title: "Impossible", message: msg, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    private func setupPickerviewsWithDefaultValues(){
        
        let posIn = exchange.currencies.getPosOfNameExchange(nameExchange: Constants.exchangeStrDefaultIn)
        if posIn >= 0 {
            DispatchQueue.main.async { 
                self.currencyPickerViewIn.selectRow(posIn, inComponent: 0, animated: true)
            }
        }
        let posOut = exchange.currencies.getPosOfNameExchange(nameExchange: Constants.exchangeStrDefaultOut)
        if posOut >= 0 {
            DispatchQueue.main.async { 
                self.currencyPickerViewOut.selectRow(posOut, inComponent: 0, animated: true)
            }
        }
    }
    private func updateData(msg: String){
        DispatchQueue.main.async {
            self.currencyPickerViewIn.reloadAllComponents()
            self.currencyPickerViewOut.reloadAllComponents()
            self.msg.text = msg
        }
    }
    
    @IBAction func moneyInChange(_ sender: UITextField) {
        if let value = sender.text {
            inChange(valTxt: value)
        }
    }
    
    private func inChange(valTxt: String){
        let (curIn, curOut) = exchange.moneyInChange(
            valTxtIn: valTxt, 
            currencyIn: currencyPickerViewIn.selectedRow(inComponent: 0), 
            currencyOut: currencyPickerViewOut.selectedRow(inComponent: 0))
        setValues(curIn: reformatStrEnter(numberStr: curIn), curOut: reformatStrWithRate(numberStr: curOut))
    }
    
    private func outChange(valTxt: String){
        let (curIn, curOut) = exchange.moneyOutChange(
            valTxtOut: valTxt, 
            currencyOut: currencyPickerViewOut.selectedRow(inComponent: 0), 
            currencyIn: currencyPickerViewIn.selectedRow(inComponent: 0))
        setValues(curIn: reformatStrWithRate(numberStr: curIn), curOut: reformatStrEnter(numberStr: curOut))
    }
    
    @IBAction func moneyOutChange(_ sender: UITextField) {
        if let value = sender.text {
            outChange(valTxt: value)
        }
    }
    private func setValues(curIn: String, curOut: String){
        DispatchQueue.main.async {
            self.moneyIn.text = curIn
            self.moneyOut.text = curOut
        }
    }
    private func reformatStrWithRate(numberStr: String) -> String {
        if !numberStr.contains("e") {
            var nSplitPoint = numberStr.split(separator: ".")
            if nSplitPoint.count == 2 {
                if nSplitPoint[1].count > 2 {
                    nSplitPoint[1] = nSplitPoint[1].prefix(2)
                }
                if Int(nSplitPoint[1]) == 0 {
                    nSplitPoint.remove(at: 1)
                }
            }
            return nSplitPoint.joined(separator: ".")
        } else {
            return numberStr
        }
    }
    private func reformatStrEnter(numberStr: String) -> String {
        if  numberStr.split(separator: "e").count == 2 {
            return numberStr
        } else {
            var nSplitPoint = numberStr.split(separator: ".")
            if nSplitPoint.count == 2 {
                let i0 = Int(nSplitPoint[0]) ?? 0
                nSplitPoint[0] = "\(i0)"
                return nSplitPoint.joined(separator: ".")
            } else {
                let i = Int(nSplitPoint[0]) ?? 0
                return "\(i)" + (numberStr.contains(".") ? "." : "")
            }
        }
    }
    private func resetValues(){
        DispatchQueue.main.async {
            self.moneyIn.text = "0"
            self.moneyOut.text = "0"
            
        }
    }
    
    //MARK: - pickerView
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1 {
            if let value = moneyIn.text {
                inChange(valTxt: value)
            }
        }
        if pickerView.tag == 2 {
            if let value = moneyOut.text {
                outChange(valTxt: value)
            }
        }        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return exchange.currencies.names.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return exchange.currencies.names[row]
    }
    
}

