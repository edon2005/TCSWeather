//
//  TCSWeatherTests.swift
//  TCSWeatherTests
//
//  Created by Yevhen Don on 08/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import XCTest
@testable import TCSWeather
import Mapper
import RxSwift
import RxCocoa
import Result

class TCSWeatherTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWeatherByCity() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    
    func testCreateModelByGeo() {
        let jsonData =
        """
        {"coord":{"lon":139,"lat":35},
        "sys":{"country":"JP","sunrise":1369769524,"sunset":1369821049},
        "weather":[{"id":804,"main":"clouds","description":"overcast clouds","icon":"04n"}],
        "main":{"temp":289.5,"humidity":89,"pressure":1013,"temp_min":287.04,"temp_max":292.04},
        "wind":{"speed":7.31,"deg":187.002},
        "rain":{"3h":0},
        "clouds":{"all":92},
        "dt":1369824698,
        "id":1851632,
        "name":"Shuzenji",
        "cod":200}
        """.data(using: .utf8)!
        let jsonDict = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! NSDictionary
        do {
            let modelWeather = try ModelWeather(map: Mapper(JSON: jsonDict))
            XCTAssert(modelWeather.name == "Shuzenji" && modelWeather.main.temp == 289.5)
        } catch {
            XCTAssert(false)
        }
    }
    
    func testViewModelByGeo() {
        
        class ioFakeByGeo: WeatherRequestType {
            let jsonData =
                """
        {"coord":{"lon":139,"lat":35},
        "sys":{"country":"JP","sunrise":1369769524,"sunset":1369821049},
        "weather":[{"id":804,"main":"clouds","description":"overcast clouds","icon":"04n"}],
        "main":{"temp":289.5,"humidity":89,"pressure":1013,"temp_min":287.04,"temp_max":292.04},
        "wind":{"speed":7.31,"deg":187.002},
        "rain":{"3h":0},
        "clouds":{"all":92},
        "dt":1369824698,
        "id":1851632,
        "name":"Shuzenji",
        "cod":200}
        """.data(using: .utf8)!

            func proceed(_ response: PublishSubject<Result<ModelWeather, ioError>>) {
                let jsonDict = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! NSDictionary
                let modelWeather = try! ModelWeather(map: Mapper(JSON: jsonDict))
                response.onNext(.success(modelWeather))
            }

        }
        
        let viewModel = ShowWeatherViewModel(ioApi: ioFakeByGeo())
        viewModel.source.
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
