//
//  Service.swift
//  OviaTakeHome
//
//  Created by Jian Ma on 3/6/22.
//

import Foundation

class Service {
    class func getList(quary: String, completion: @escaping(Swift.Result<SearchData, Error>) -> Void) {
        ServiceManager.shared.sendRequest(SearchRequestModel(quary: quary)) { (result) in
            completion(result)
        }
    }
    class func getRating(with id: String,completion: @escaping(Swift.Result<RatingData, Error>) -> Void) {
        ServiceManager.shared.sendRequest(MovieRequestModel(id)) { (result) in
            completion(result)
        }
    }
    class func getImage() {
        
    }
}

class ServiceManager {
    static let shared = ServiceManager()
}

extension ServiceManager {
    func sendRequest<T: Codable>(_ requestModel: RequestModel, completion: @escaping (Result<T, Error>) -> Void){
        guard let url = URL(string: requestModel.requestString()) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let dat = data, var responseData = try? JSONDecoder().decode(ResponseModel<T>.self, from: dat) else {return}
            responseData.rawData = dat
            if let rawData = responseData.rawData,
               let responseData = try? JSONDecoder().decode(T.self, from: rawData){
                completion(Result.success(responseData))
            } else {
                completion(.failure(NetWorkError.generalError) )
            }
        }.resume()
    }
}

enum NetWorkError: Error {
    case generalError
}

