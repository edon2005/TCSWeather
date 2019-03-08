//
//  ioTransform.swift
//  TCSWeather
//
//  Created by Yevhen Don on 08/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import Moya_ModelMapper
import Moya
import Mapper


//Transform response if it is array or only one element
class ioTransform {
    static func map<T: Mappable>(_ data: Response) throws -> T {
        return try data.map(to: T.self)
    }
    
    static func map<T: Mappable>(_ data: Response) throws -> [T] {
        guard let jsonArray = try data.mapJSON() as? NSArray else {
            throw MoyaError.jsonMapping(data)
        }
        if jsonArray.count > 0 {
            do {
                return try data.map(to: [T].self)
            } catch (let error) {
                throw error
            }
        } else {
            return [T]()
        }
    }
}
