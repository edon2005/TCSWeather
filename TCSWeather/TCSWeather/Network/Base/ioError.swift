//
//  ioError.swift
//  TCSWeather
//
//  Created by Yevhen Don on 08/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import Mapper

struct ioError: Error {
    let code: Int
    let description: String
}

//Mappable error from JSON.
class ioErrorMap: Mappable {
    var error: String
    var status: String
    
    required init(map: Mapper) throws {
        try error = map.from("cod")
        try status = map.from("message")
    }
}
