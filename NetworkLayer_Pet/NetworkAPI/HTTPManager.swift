//
//  NetworkLayer.swift
//  NetworkRouter
//
//  Created by Evgeniy Stoyan on 29.08.2024.
//  Copyright © 2024 com.gmail@sev1001. All rights reserved.
//

import Foundation

protocol HTTPService {
    func fetch<Response>(endpoint: HTTPEndpointable,
                         type: Response.Type,
                         receiveOn queue: DispatchQueue,
                         _ finished: @escaping (HTTPResult<Response, Error>) -> Void) where Response: Codable
}
class HTTPManager: HTTPService {
    enum Errors: Error {
        case invalidHTTPResponseStatusCode(Int)
    }
    private let client: HTTPClient
    private let decoder: JSONDecoder
    
    init(client: HTTPClient = URLSession.shared,
         decoder: JSONDecoder = JSONDecoder()) {
        self.client = client
        self.decoder = decoder
    }
    
    func fetch<Response>(endpoint: HTTPEndpointable,
                         type: Response.Type,
                         receiveOn queue: DispatchQueue,
                         _ finished: @escaping (HTTPResult<Response, Error>) -> Void) where Response : Decodable, Response : Encodable {
        do {
            let request = try endpoint.request()
            let task = client.fetch(request: request) {[weak self] result in
                guard let self else {return}
                switch result {
                case let .success((data, httpResponse)):
                    do {
                        try validate(httpResponse: httpResponse)
                        let decodedResponse = try decoder.decode(Response.self, from: data)
                        queue.async {
                            finished(.success(decodedResponse))
                        }
                    } catch {
                        queue.async {
                            finished(.failure(error))
                        }
                    }
                case let .failure(error):
                    queue.async {
                        finished(error.isURLRequestCancelled  ? .cancelled : .failure(error))
                    }
                }
            }
            task.start()
        } catch {
            queue.async {
                finished(.failure(error))
            }
        }
    }
}
private extension HTTPManager {
    func validate(httpResponse: HTTPURLResponse) throws {
        guard 200...201 ~= httpResponse.statusCode else {
            throw Errors.invalidHTTPResponseStatusCode(httpResponse.statusCode)
        }
    }
}
