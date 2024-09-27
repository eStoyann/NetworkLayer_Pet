//
//  HTTPBody.swift
//  NetworkLayer_Pet
//
//  Created by Evgeniy Stoyan on 27.09.2024.
//

import Foundation

protocol HTTPBody {
    func create() throws -> Data
}

struct DefaultHTTPBody: HTTPBody {
    let parameters: [String: Any]

    init(parameters: [String : Any]) {
        self.parameters = parameters
    }
    
    func create() throws -> Data {
        try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    }
}
