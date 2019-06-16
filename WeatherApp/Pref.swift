//
//  Pref.swift
//  WeatherApp
//
//  Created by 潤田中 on 2019/06/15.
//  Copyright © 2019 BCC. All rights reserved.
//


import Foundation
import SwiftyJSON

class Pref {
    let title: String
    let cities: [City]
    
    init(pref: JSON) {
        title = pref["title"].stringValue
        cities = pref["city"].arrayValue.map({ item in
            return City(city: item)
        })
    }
}
