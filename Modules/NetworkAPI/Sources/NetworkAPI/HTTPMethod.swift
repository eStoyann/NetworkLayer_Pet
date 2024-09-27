//
//  HTTPMethod.swift
//  NetworkRouter
//
//  Created by Evgeniy Stoyan on 09.09.2024.
//  Copyright © 2024 com.gmail@sev1001. All rights reserved.
//

import Foundation

public enum HTTPMethod {
    case get
    case post(HTTPBody)
    case delete
    case put
    case patch
    
    var value: String {
        switch self {
        case .delete:
            return "DELETE"
        case .get:
            return "GET"
        case .patch:
            return "PATCH"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        }
    }
    public var httpBody: HTTPBody? {
        if case let .post(data) = self {
            return data
        }
        return nil
    }
}
