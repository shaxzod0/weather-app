//
//  Model.swift
//  Weather app
//
//  Created by Shaxzod Azamatjonov on 23/02/22.
//

import UIKit

struct WeatherModel:Decodable{
    let location: Location
    let current: Current
    let forecast: Forecast
}

struct Location:Decodable{
    let name: String
    let region: String
}

struct Current: Decodable{
    let temp_c: Float
    let condition: Condition
}
struct Condition:Decodable{
    let icon: String
    let text: String
}

struct Forecast:Decodable{
    let forecastday: [ForecastDay]
}
struct ForecastDay:Decodable{
    let date: String
    let date_epoch: Int
    let day: Day
    let hour: [Hour]
}
struct Day:Decodable{
    let maxtemp_c: Float
    let maxtemp_f: Float
    let condition: Condition
}
struct Hour:Decodable{
    let time: String
    let temp_c: Float
    let temp_f: Float
    let condition: Condition
}
