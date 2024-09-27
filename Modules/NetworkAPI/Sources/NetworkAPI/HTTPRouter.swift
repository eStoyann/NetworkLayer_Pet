//
//  HTTPRouter.swift
//  NetworkRouter
//
//  Created by Evgeniy Stoyan on 09.09.2024.
//  Copyright © 2024 com.gmail@sev1001. All rights reserved.
//

import Foundation

public enum HTTPRouter {
    case posts
    
    public var endpoint: HTTPEndpoint {
        switch self {
        case .posts:
            let path = "/posts"
            let builder = URLBuilder(host: HTTPHost.urlPath, path: path)
            let endpoint = Endpoint(urlBuilder: builder)
            return endpoint
        }
    }
}
