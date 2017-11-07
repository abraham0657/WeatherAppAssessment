//
//  DetailViewController.swift
//  Weather
//
//  Created by Abraham Tesfamariam on 11/3/17.
//  Copyright © 2017 RJT Compuquest. All rights reserved.
//

import UIKit
import SDWebImage
import TWMessageBarManager

class DetailViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var weatherReport: WeatherReport?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpScreen()
    }

    /*
     @description: Assigns data to their UI elements
     @param: Void
     @return: Void
     */
    fileprivate func setUpScreen() {
        guard let report = weatherReport else { return }
        
        cityNameLabel.text = report.cityName
        descriptionLabel.text = report.weatherForecast[0].desc
        minTempLabel.text = "Low: \(Int(report.minTemp))℉"  // Int parsing to remove decimals
        maxTempLabel.text = "High: \(Int(report.maxTemp))℉"
        tempLabel.text = "\(Int(report.temp))℉"
        windSpeedLabel.text = "Wind Speed: \(report.windSpeed)mph"
        
        if let iconURL = URL(string: ConfigConstants.iconAPI.rawValue + report.weatherForecast[0].icon + ".png") {
            iconImageView.sd_setImage(with: iconURL, completed: nil)
        }
    }

    /*
     @description: Fetches weather data
     @param cityName: String query for city name
     @return: Void
     */
    func fetchData(cityName: String) {
        WeatherService.shared.fetchData(cityName: cityName) { (report, error) in
            if error == nil {
                self.weatherReport = report
                
                DispatchQueue.main.async {
                    self.setUpScreen()
                }
            } else {
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "Error Fetching Data", description: error?.localizedDescription, type: .error)
            }
        }
    }
    
    /*
     @description: Presents search screen
     @param: sender UIButton
     @return: Void
     */
    @IBAction func searchPressed(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.changeRootVC()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
