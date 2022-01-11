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
    
    @IBOutlet weak var labelTempCity1: UILabel!
    @IBOutlet weak var labelTempCity2: UILabel!

    @IBOutlet weak var labelDetailCity2: UILabel!
    @IBOutlet weak var labelDetailCity1: UILabel!
    
    @IBOutlet weak var labelWeatherMain1: UILabel!
    @IBOutlet weak var labelWeatherMain2: UILabel!
    
    @IBOutlet weak var imgSun11: UIImageView!
    @IBOutlet weak var imgSun12: UIImageView!
    
    @IBOutlet weak var labelHour11: UILabel!
    @IBOutlet weak var labelHour12: UILabel!
    
    @IBOutlet weak var imgSun21: UIImageView!
    @IBOutlet weak var imgSun22: UIImageView!
    
    @IBOutlet weak var labelHour21: UILabel!
    @IBOutlet weak var labelHour22: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modelWeather = ModelWeather.shared        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadLastValues()
    }

    private func updateValuesCity() {
        DispatchQueue.main.async { [self] in
            labelNameCity1.text = modelWeather.weatherCities[0].cityName!
            labelTempCity1.text = modelWeather.weatherCities[0].weather!.current.temp.description + "°c"
            labelDetailCity1.text = modelWeather.weatherCities[0].weather!.current.weather[0].description
            labelWeatherMain1.text = modelWeather.weatherCities[0].weather!.current.weather[0].main
            let nameIcon1 = modelWeather.weatherCities[0].weather!.current.weather[0].icon
            if let img1 = UIImage(named: nameIcon1 + ".png") {
                imageWeatherC1.image = img1
            }

            let nameSunUp1 = "up-d"
            if let img11 = UIImage(named: nameSunUp1 + ".png") {
                imgSun11.image = img11
            }
            let nameSunDown1 = "down-d"
            if let img12 = UIImage(named: nameSunDown1 + ".png") {
                imgSun12.image = img12
            }
            labelHour11.text = convertTimeInDoubleToString(double: modelWeather.weatherCities[0].weather!.current.sunrise + Double(modelWeather.weatherCities[0].weather!.timezone_offset))
            labelHour12.text = convertTimeInDoubleToString(double: modelWeather.weatherCities[0].weather!.current.sunset + Double(modelWeather.weatherCities[0].weather!.timezone_offset))
            
            labelNameCity2.text = modelWeather.weatherCities[1].cityName!
            labelTempCity2.text = modelWeather.weatherCities[1].weather!.current.temp.description + "°c"
            labelDetailCity2.text = modelWeather.weatherCities[1].weather!.current.weather[0].description
            labelWeatherMain2.text = modelWeather.weatherCities[1].weather!.current.weather[0].main
            let nameIcon2 = modelWeather.weatherCities[1].weather!.current.weather[0].icon
            if let img2 = UIImage(named: nameIcon2 + ".png") {
                imageWeatherC2.image = img2
            }
            let nameSunUp2 = "up-d"
            if let img21 = UIImage(named: nameSunUp2 + ".png") {
                imgSun21.image = img21
            }
            let nameSunDown2 = "down-d"
            if let img22 = UIImage(named: nameSunDown2 + ".png") {
                imgSun22.image = img22
            }
            labelHour21.text = convertTimeInDoubleToString(double: modelWeather.weatherCities[1].weather!.current.sunrise + Double(modelWeather.weatherCities[1].weather!.timezone_offset))
            labelHour22.text = convertTimeInDoubleToString(double: modelWeather.weatherCities[1].weather!.current.sunset + Double(modelWeather.weatherCities[1].weather!.timezone_offset))
        }
    }
    
    func convertTimeInDoubleToString(double: Double) -> String {
        let date = Date(timeIntervalSince1970: double)
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        return format.string(from: date)
    }
    
    private func showError(_ failure: String) {
        print("ControllerWeather", failure)
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
