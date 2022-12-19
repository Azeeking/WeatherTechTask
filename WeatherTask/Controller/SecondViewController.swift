//
//  SecondViewController.swift
//  WeatherTask
//
//  Created by Azik on 19.12.2022.
//

import Foundation
import UIKit

class SecondViewController : UIViewController {
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var cityName : String = ""
    
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        networkManager.delegate = self
        cityLabel.text = cityName
        networkManager.getWeather(by: cityLabel.text!)
    }
}

extension SecondViewController : NetworkManagerDelegate {
    func updateWeather(with model: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = model.temperatureString
            self.conditionImageView.image = UIImage(systemName: model.conditionName)
            self.cityLabel.text = model.cityName
        }
    }
}
