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
    var main: MainData
    
    required init(map: Mapper) throws {
        main = try map.from("main")
        print (main)
    }
}
