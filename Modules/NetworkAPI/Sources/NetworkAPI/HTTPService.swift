//
//  NetworkLayer.swift
//  NetworkRouter
//
//  Created by Evgeniy Stoyan on 29.08.2024.
//  Copyright © 2024 com.gmail@sev1001. All rights reserved.
//

import Foundation

public protocol HTTPService: Sendable {
    func fetch<Response>(endpoint: HTTPEndpoint,
                         type: Response.Type,
                         receiveOn queue: DispatchQueue,
                         _ finished: @escaping @Sendable (HTTPResult<Response>) -> Void) where Response: Codable
}
public final class HTTPManager: HTTPService {
    public enum Errors: Error {
        case invalidHTTPResponse(statusCode: Int)
    }
    private let client: HTTPClient
    private let decoder: JSONDecoder
    
    public init(client: HTTPClient = URLSession.shared,
         decoder: JSONDecoder = JSONDecoder()) {
        self.client = client
        self.decoder = decoder
    }
    
    public func fetch<Response>(endpoint: HTTPEndpoint,
                         type: Response.Type,
                         receiveOn queue: DispatchQueue,
                         _ finished: @escaping @Sendable (HTTPResult<Response>) -> Void) where Response : Decodable, Response : Encodable, Response: Sendable {
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
        guard 200...299 ~= httpResponse.statusCode else {
            throw Errors.invalidHTTPResponse(statusCode: httpResponse.statusCode)
        }
    }
}
