//
//  ViewControllerTranslate.swift
//  intrip
//
//  Created by Gilles David on 19/12/2021.
//

import UIKit

class ViewControllerTranslate: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var textfieldIn: UITextView!    
    @IBOutlet weak var textFieldOut: UITextView!
    
    
    @IBOutlet weak var pickerViewIn: UIPickerView!
    @IBOutlet weak var pickerViewOut: UIPickerView!
    
    @IBOutlet weak var buttonGetTranslate: UIButton!
    @IBOutlet weak var buttonReverse: UIButton!
    
    @IBOutlet weak var textfieldLangIn: UILabel!
    @IBOutlet weak var textfieldLangOut: UILabel!
    
    @IBOutlet weak var switchAutodetect: UISegmentedControl!
    
    
    private var translate: ModelTranslate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
        translate = ModelTranslate.shared
        
        switchAutodetect.setWidth(75, forSegmentAt: 1)
        switchAutodetect.selectedSegmentIndex = 1
        
        initPickers()
        
        textfieldIn.becomeFirstResponder()        
    }
    private func textViewDidEndEditing(_ textView: UITextView) {
        if textfieldIn.text.isEmpty {
            textfieldIn.text = "Placeholder"
            textfieldIn.textColor = UIColor.lightGray
        }
    }

    @IBAction func switchAutodetectChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            pickerViewIn.isUserInteractionEnabled = false
            pickerViewIn.alpha = 0.25
        } else {
            pickerViewIn.isUserInteractionEnabled = true
            pickerViewIn.alpha = 1
        }
    }
    func getSelectedLanguages() -> (langIn: String, langOut:String) {
        let pi = pickerViewIn.selectedRow(inComponent: 0)
        let po = pickerViewOut.selectedRow(inComponent: 0)
        return (langIn: translate.getLangInLanguage(pos: pi), langOut: translate.getLangInLanguage(pos:po))
    }
    func getCodeSelectedLanguages() -> (langIn: String, langOut:String) {
        let pi = pickerViewIn.selectedRow(inComponent: 0)
        let po = pickerViewOut.selectedRow(inComponent: 0)
        return (langIn: translate.getCodeInLanguage(pos: pi), langOut: translate.getCodeInLanguage(pos:po))
    }

    
    @IBAction func getTranslate(_ sender: UIButton) {
        if let textToTranslate = textfieldIn.text {
            if textToTranslate.count > 0{
                let lang = getCodeSelectedLanguages()
                let autodetect = switchAutodetect.selectedSegmentIndex
                
                translate.getTranslateSentence(
                    textToTranslate: textToTranslate, 
                    langIn: lang.langIn, 
                    langOut: lang.langOut, 
                    autoDetect: (autodetect == 0), 
                    completion : { [self]
                        response in 
                        switch response {
                        case .Success(let response):
                            showResponse(response: response.text)
                        case .Failure(let error):
                            print("Failure", error.localizedDescription)
                            switch error {
                            case .returnNil:
                                print("Failure returnNil", error.localizedDescription)
                            case .statusCodeWrong:
                                print("Failure statusCodeWrong", error.localizedDescription)
                            case .decodeError:
                                print("Failure decodeError", error.localizedDescription)
                            }
                        }
                    }
                )
                dismissMyKeyboard()
            }
        }
    }
    
    func showResponse(response: String){
        DispatchQueue.main.async {
            self.textFieldOut.text = response
        }
    }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
    
    
    //MARK: - pickerView
    @IBAction func reverse(_ sender: UIButton) {
        let pi = pickerViewIn.selectedRow(inComponent: 0)
        let po = pickerViewOut.selectedRow(inComponent: 0)
        
        pickerViewOut.selectRow(pi, inComponent: 0, animated: true)
        pickerViewIn.selectRow(po, inComponent: 0, animated: true)
        
        updateLabelLanguages()
    }
    
    func initPickers(){
        if translate.languages.count > 0 {
            DispatchQueue.main.async { [self] in 
                let posLangIn = translate.getPosInLanguage(lan: "FR")
                if posLangIn >= 0 {
                        self.pickerViewIn.selectRow(posLangIn, inComponent: 0, animated: true)
                    textfieldLangIn.text = translate.languages[posLangIn].lang
                }
                let posLangOut = translate.getPosInLanguage(lan: "EN")
                if posLangOut >= 0 {
                        self.pickerViewOut.selectRow(posLangOut, inComponent: 0, animated: true)
                    textfieldLangOut.text = translate.languages[posLangOut].lang
                }
            }
        }
    }
    private func updateLabelLanguages() {
        let lang = getSelectedLanguages()
        textfieldLangIn.text = lang.langIn
        textfieldLangOut.text = lang.langOut
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateLabelLanguages()     
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return translate.languages.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return translate.languages[row].code
    }

}
