//
//  Url.swift
//  Weather app
//
//  Created by Shaxzod Azamatjonov on 23/02/22.
//

import Foundation
class AppUrl{
    static let shared = AppUrl()
    static let baseUrl = "http://api.weatherapi.com/v1/"
    static let currentUrl = baseUrl + "current.json?key= %201d8124e9f40641d499e51148222302&q="
}
