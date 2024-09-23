//
//  HTTPClient.swift
//  NetworkRouter
//
//  Created by Evgeniy Stoyan on 09.09.2024.
//  Copyright © 2024 com.gmail@sev1001. All rights reserved.
//

import Foundation

protocol HTTPClient {
    typealias CompletionHandler = (Result<(Data, HTTPURLResponse), Error>) -> Void
    func fetch(request: URLRequest,
               _ finished: @escaping CompletionHandler) -> HTTPURLSessionTask
}
//common usage
//just run request and get response data
extension URLSession: HTTPClient {
    func fetch(request: URLRequest,
               _ finished: @escaping CompletionHandler) -> HTTPURLSessionTask {
        dataTask(with: request) { data, response, error in
            guard error == nil else {
                finished(.failure(error!))
                return
            }
            guard let data, !data.isEmpty else {
                finished(.failure(URLError(.dataNotAllowed)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                finished(.failure(URLError(.badServerResponse)))
                return
            }
            finished(.success((data, httpResponse)))
        }
    }
}

