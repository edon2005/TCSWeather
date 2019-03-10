//
//  ModelWeather.swift
//  TCSWeather
//
//  Created by Yevhen Don on 10/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import Mapper

//short prototype of model getting from openweather as JSON
class ModelWeather: Mappable {
    let main: MainData
    let name: String
    
    required init(map: Mapper) throws {
        main = try map.from("main")
        name = try map.from("name")
        print (name, main)
    }
}
