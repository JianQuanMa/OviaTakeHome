//
//  RequestModel.swift
//  OviaTakeHome
//
//  Created by Jian Ma on 3/6/22.
//

import Foundation

class SearchRequestModel: RequestModel {
    private var quary: String
    let baseURLString = "http://www.omdbapi.com/?apikey=ee60b1cc&"
    init(quary: String) {
        self.quary = quary
    }
    
    func requestString() -> String {
        return baseURLString + "s=\(quary)"
    }
}

class MovieRequestModel: RequestModel {
    private var id: String
    var baseURLString = "http://www.omdbapi.com/?apikey=ee60b1cc&"
    init(_ id: String) {
        self.id = id
    }
    func requestString() -> String {
        return baseURLString + "i=\(id)"
    }
}

protocol RequestModel {
    var baseURLString: String { get }
    func requestString() -> String
}
