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
    
    @IBOutlet weak var labelWeatherMain1: UILabel!
    @IBOutlet weak var labelWeatherMain2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modelWeather = ModelWeather.shared        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadLastValues()
    }

    private func updateValuesCity() {
        labelNameCity1.text = modelWeather.weatherCities[0].cityName!
        labelTempCity1.text = modelWeather.weatherCities[0].weather!.current.temp.description + "°c"
        labelDetailCity1.text = modelWeather.weatherCities[0].weather!.current.weather[0].description
        labelWeatherMain1.text = modelWeather.weatherCities[0].weather!.current.weather[0].main
        let nameIcon1 = modelWeather.weatherCities[0].weather!.current.weather[0].icon
        if let img1 = UIImage(named: nameIcon1 + ".png") {
            imageWeatherC1.image = img1
        }
        
        labelNameCity2.text = modelWeather.weatherCities[1].cityName!
        labelTempCity2.text = modelWeather.weatherCities[1].weather!.current.temp.description + "°c"
        labelDetailCity2.text = modelWeather.weatherCities[1].weather!.current.weather[0].description
        labelWeatherMain2.text = modelWeather.weatherCities[1].weather!.current.weather[0].main
        let nameIcon2 = modelWeather.weatherCities[1].weather!.current.weather[0].icon
        print(nameIcon2 + ".png")
        if let img2 = UIImage(named: nameIcon2 + ".png") {
            imageWeatherC2.image = img2
        }
    }
    private func showError(_ failure: String) {
    }
    
    private func loadLastValues() {
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

}
