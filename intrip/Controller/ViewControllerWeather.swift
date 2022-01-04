//
//  ViewControllerWeather.swift
//  intrip
//
//  Created by Gilles David on 19/12/2021.
//

import UIKit

class ViewControllerWeather: UIViewController {

    private var modelWeather: ModelWeather!
    @IBOutlet weak var labelNameCity1: UILabel!
    @IBOutlet weak var labelNameCity2: UILabel!
    
    @IBOutlet weak var imageWeatherC1: UIImageView!
    @IBOutlet weak var imageWeatherC2: UIImageView!
    
    @IBOutlet weak var labelTempCity1: UITextField!
    @IBOutlet weak var labelTempCity2: UITextField!
    
    @IBOutlet weak var labelDetailCity1: UITextField!
    @IBOutlet weak var labelDetailCity2: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modelWeather = ModelWeather.shared

        modelWeather.updateWeather(callBack:{
            response in
            switch response {
            case .Success:
                self.updateValuesCity()
            case .Failure(failure : let failure):
                self.showError(failure)
            }
        })
        
    }

    private func updateValuesCity() {
        labelNameCity1.text = modelWeather.weatherCities[0].cityName!
        labelTempCity1.text = modelWeather.weatherCities[0].weather!.current.temp.description
        
        labelNameCity2.text = modelWeather.weatherCities[1].cityName!
        labelTempCity2.text = modelWeather.weatherCities[1].weather!.current.temp.description
    }
    private func showError(_ failure: String) {
    }
    
}
