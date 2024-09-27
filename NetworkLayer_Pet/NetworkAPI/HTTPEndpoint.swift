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
            request.httpBody = try httpBody.data()
        }
        return request
    }
}


protocol HTTPBody {
    func data() throws -> Data
}

struct MultipartData: HTTPBody {
    let boundary: String
    let fileData: Data
    let fileName: String
    
    init(boundary: String = UUID().uuidString,
         fileData: Data,
         fileName: String) {
        self.boundary = boundary
        self.fileData = fileData
        self.fileName = fileName
    }
    
    func data() throws -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        body.append("--\(boundary)")
        body.append(lineBreak)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\(fileName)")
        body.append(lineBreak)
        body.append("Content-Type: image/jpeg")
        body.append(lineBreak)
        body.append(lineBreak)
        body.append(fileData)
        body.append(lineBreak)
        body.append("--\(boundary)--")
        body.append(lineBreak)
        return body
    }
}
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}


struct DefaultHTTPBody: HTTPBody {
    private let parameters: [String: Any]

    init(parameters: [String : Any]) {
        self.parameters = parameters
    }
    
    func data() throws -> Data {
        try JSONSerialization.data(withJSONObject: parameters)
    }
}
