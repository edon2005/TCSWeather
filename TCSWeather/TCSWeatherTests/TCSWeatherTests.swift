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
import RxBlocking

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
        let jsonData =
        """
        {"coord":{"lon":-0.13,"lat":51.51},"weather":[{"id":300,"main":"Drizzle","description":"light intensity drizzle","icon":"09d"}],"base":"stations","main":{"temp":280.32,"pressure":1012,"humidity":81,"temp_min":279.15,"temp_max":281.15},"visibility":10000,"wind":{"speed":4.1,"deg":80},"clouds":{"all":90},"dt":1485789600,"sys":{"type":1,"id":5091,"message":0.0103,"country":"GB","sunrise":1485762037,"sunset":1485794875},"id":2643743,"name":"London","cod":200}
        """.data(using: .utf8)!
        
        let jsonDict = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! NSDictionary
        do {
            let modelWeather = try ModelWeather(map: Mapper(JSON: jsonDict))
            XCTAssert(modelWeather.name == "London" && modelWeather.main.temp == 280.32)
        } catch {
            XCTAssert(false)
        }

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
        viewModel.request()
        XCTAssertNotNil(try viewModel.source.toBlocking().first() as? ModelWeather)
    }
    
    func testJsonFailed() {
        let jsonData =
            """
        {"coord":{"lon":139,"lat":35},
        "cod":200}
        """.data(using: .utf8)!
        let jsonDict = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! NSDictionary
        do {
            let _ = try ModelWeather(map: Mapper(JSON: jsonDict))
            XCTAssert(false)
        } catch {
            XCTAssert(true)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
