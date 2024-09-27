//
//  HTTPBody.swift
//  NetworkLayer_Pet
//
//  Created by Evgeniy Stoyan on 27.09.2024.
//

import Foundation

public protocol HTTPBody {
    func create() throws -> Data
}

public struct DefaultHTTPBody: HTTPBody {
    let parameters: [String: Any]

    init(parameters: [String : Any]) {
        self.parameters = parameters
    }
    
    public func create() throws -> Data {
        try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    }
}
