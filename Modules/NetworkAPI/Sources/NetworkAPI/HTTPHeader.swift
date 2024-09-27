//
//  HTTPHeader.swift
//  NetworkRouter
//
//  Created by Evgeniy Stoyan on 09.09.2024.
//  Copyright © 2024 com.gmail@sev1001. All rights reserved.
//

import Foundation

public enum HTTPHeader: String {
    case contentType = "Content-Type"
    
    public var value: String {
        switch self {
        case .contentType:
            return "application/json"
        }
    }
}
