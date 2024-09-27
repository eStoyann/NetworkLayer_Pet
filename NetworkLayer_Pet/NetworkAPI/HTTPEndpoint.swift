//
//  HTTPEndpoint.swift
//  NetworkRouter
//
//  Created by Evgeniy Stoyan on 09.09.2024.
//  Copyright © 2024 com.gmail@sev1001. All rights reserved.
//

import Foundation

protocol HTTPEndpoint {
    func request() throws -> URLRequest
}
struct Endpoint: HTTPEndpoint {
    let builder: HTTPURLBuilder
    let httpMethod: HTTPMethod
    let httpHeaders: [HTTPHeader]
    let timeoutInterval: TimeInterval
    let cachePolicy: URLRequest.CachePolicy
    
    init(urlBuilder: HTTPURLBuilder,
         httpMethod: HTTPMethod = .get,
         httpHeaders: [HTTPHeader] = [.contentType],
         cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
         timeoutInterval: TimeInterval = 60) {
        self.builder = urlBuilder
        self.httpMethod = httpMethod
        self.httpHeaders = httpHeaders
        self.timeoutInterval = timeoutInterval
        self.cachePolicy = cachePolicy
    }
    
    func request() throws -> URLRequest {
        guard let url = builder.url else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url,
                                 cachePolicy: cachePolicy,
                                 timeoutInterval: timeoutInterval)
        request.httpMethod = httpMethod.value
        httpHeaders.forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.rawValue)
        }
        if let httpBody = httpMethod.httpBody {
            request.httpBody = try httpBody.create()
        }
        return request
    }
}
