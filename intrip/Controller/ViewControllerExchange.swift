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
    
    private var exchange: ModelExchange!
//    private var arrayExchange: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                self.msg.text = failure.localizedDescription
            }
        })
    }
    
    private func setupPickerviewsWithDefaultValues(){
        let posIn = exchange.currencies.getPosOfNameExchange(nameExchange: Constants.exchangeStrDefaultIn)
        if posIn >= 0 {
            currencyPickerViewIn.selectRow(posIn, inComponent: 0, animated: true)
        }
        let posOut = exchange.currencies.getPosOfNameExchange(nameExchange: Constants.exchangeStrDefaultOut)
        if posOut >= 0 {
            currencyPickerViewOut.selectRow(posOut, inComponent: 0, animated: true)
        }
    }
    private func updateData(msg: String){
        self.currencyPickerViewIn.reloadAllComponents()
        self.currencyPickerViewOut.reloadAllComponents()
        self.msg.text = msg
    }
    
    @IBAction func moneyInChange(_ sender: UITextField) {
        inChange(sender.text!)
    }
    
    private func inChange(_ valTxt: String){
        let doubleMoneyIn = checkFormat(valTxt)
        if doubleMoneyIn == 0 {
            resetValues()
        } else {
            moneyOut.text = (doubleMoneyIn * getRatio()).description
        }
    }
    
    private func outChange(_ valTxt: String){
        let doubleMoneyOut = checkFormat(valTxt)
        if doubleMoneyOut == 0 {
            resetValues()
        } else {
            moneyIn.text = (doubleMoneyOut / getRatio()).description
        }
    }
    
    private func getRatio() -> Double {
        return exchange.currencies.getRatio(currencyPickerViewIn.selectedRow(inComponent: 0), currencyPickerViewOut.selectedRow(inComponent: 0))
    }
    
    @IBAction func moneyOutChange(_ sender: UITextField) {
        outChange(sender.text!)
    }
    private func resetValues(){
        moneyIn.text = "0"
        moneyOut.text = "0"
    }
    private func checkFormat(_ txt: String) -> Double{
        let myDouble = Double(txt) ?? 0.0
        return myDouble
    }
    
    //MARK: - pickerView
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1 {
            inChange(moneyIn.text!)
        }
        if pickerView.tag == 2 {
            outChange(moneyOut.text!)
        }        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        exchange.currencies.names.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return exchange.currencies.names[row]
    }
    
}

