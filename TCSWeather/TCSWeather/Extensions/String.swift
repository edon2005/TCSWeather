//
//  String.swift
//  TCSWeather
//
//  Created by Yevhen Don on 08/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation

//decode string to Data
extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
