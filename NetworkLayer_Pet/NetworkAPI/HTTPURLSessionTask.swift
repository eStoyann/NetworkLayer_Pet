//
//  HTTPURLSessionTask.swift
//  NetworkRouter
//
//  Created by Evgeniy Stoyan on 09.09.2024.
//  Copyright © 2024 com.gmail@sev1001. All rights reserved.
//

import Foundation

protocol HTTPURLSessionTask {
    func stop()
    func start()
}

extension URLSessionTask: HTTPURLSessionTask {
    func stop() {
        cancel()
    }
    func start() {
        resume()
    }
}
