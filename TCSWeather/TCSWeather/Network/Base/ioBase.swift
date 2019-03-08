//
//  ioBase.swift
//  TCSWeather
//
//  Created by Yevhen Don on 08/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import Moya
import Result

//Generetic class to send different Data.
class ioBase {
    func request<T: ioRequestAccess>(_ parameter: T) {
        let provider = MoyaProvider<ioService>(endpointClosure: endpointClosure)
        provider.request(parameter.endpoint){ response in
            let result: Result<T.Transform, ioError>
            switch response {
            case .success(let data):
                switch data.statusCode {
                    
                // check if success response
                case 200...399:
                    do {
                        let map = try parameter.map(data)
                        result = .success(map)
                    } catch (let error) {
                        result = .failure(ioError(code: data.statusCode, description: error.localizedDescription))
                    }
                    
                // check if got error code.
                case 400...599:
                    do {
                        result = .failure(ioError(code: data.statusCode, description: try data.map(to: ioErrorMap.self).status))
                    } catch (let error) {
                        result = .failure(ioError(code: data.statusCode, description:  error.localizedDescription))
                    }
                    break;
                default:
                    result = .failure(ioError(code: data.statusCode, description:  data.description))
                }
                
            // catch error
            case .failure(let error):
                result = .failure(ioError(code: error.response?.statusCode ?? 0, description: error.localizedDescription))
            }
            
            //send response to varibale wether it is success or failure.
            parameter.subject?.onNext(result)
        }
    }
    
    //if it needs to inject request call here needAddParam
    func endpointClosure(target: ioService) -> Endpoint {
        var endpoint = MoyaProvider.defaultEndpointMapping(for: target)
        needAddParam(target.authorizationType, param: ["appid":Constants.apiKey], endpoint: &endpoint)
        return endpoint
    }
    
    //inject request adding addons parameteres to
    private func needAddParam(_ property:AdditionalParameterType, param: [String: Any], endpoint: inout Endpoint) {
        var newParam: [String: Any] = [:]
        switch property {
        case .need:
            switch endpoint.task {
            case let .requestCompositeParameters(_, _, urlParam):
                newParam = urlParam
                param.forEach { (k,v) in
                    newParam[k] = v
                }
            default: return
            }
        default: return
        }
        newParam["units"] = Constants.unit.rawValue
        endpoint = endpoint.replacing(task: .requestCompositeParameters(bodyParameters: [:], bodyEncoding: URLEncoding.httpBody, urlParameters: newParam))
    }
    
    deinit {
        print("👍 ioBase deinited")
    }
}
