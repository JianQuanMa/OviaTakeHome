//
//  ResponseModel.swift
//  OviaTakeHome
//
//  Created by Jian Ma on 3/6/22.
//

import Foundation

struct ResponseModel<T: Codable>: Codable {
    var isSuccess: Bool
    var message: String
    
    var rawData: Data?
    var data: T?
    
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        isSuccess = (try? keyedContainer.decode(Bool.self, forKey: CodingKeys.isSuccess)) ?? false
        message = (try? keyedContainer.decode(String.self, forKey: CodingKeys.message)) ?? ""
        data = try? keyedContainer.decode(T.self, forKey: CodingKeys.data)
    }
}

extension ResponseModel {
    private enum CodingKeys: String, CodingKey {
        case isSuccess
        case message
        case data
    }
}
