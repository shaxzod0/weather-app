//
//  NetworkManager.swift
//  Weather app
//
//  Created by Shaxzod Azamatjonov on 23/02/22.
//

import Foundation
import Alamofire

class NetworkManager{
    static let shared = NetworkManager()
    
    func getWeatherCurrentLocation(param: String,
                                   complationHandler: @escaping((WeatherModel)->Void)){
        let url = "http://api.weatherapi.com/v1/forecast.json?key=%201d8124e9f40641d499e51148222302&q=\(param)&lang=en&days=5"
        AF.request(url, method: .get).validate().responseDecodable(of: WeatherModel.self){ res in
            guard let data = res.value else{
                print("Decode error")
                return
            }
            complationHandler(data)
        }
    }
}
