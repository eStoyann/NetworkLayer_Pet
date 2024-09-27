//
//  HTTPResult.swift
//  NetworkRouter
//
//  Created by Evgeniy Stoyan on 09.09.2024.
//  Copyright © 2024 com.gmail@sev1001. All rights reserved.
//

import Foundation

enum HTTPResult<Success> {
    case success(Success)
    case failure(Error)
    case cancelled
}
