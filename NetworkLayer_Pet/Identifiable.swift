//
//  Protocol+Identifiable.swift
//  NetworkRouter
//
//  Created by Evgeniy Stoyan on 09.09.2024.
//  Copyright © 2024 com.gmail@sev1001. All rights reserved.
//

import Foundation

protocol Identifiable {
    static var id: String{get}
}
extension Identifiable {
    static var id: String {
        String(describing: self)
    }
}
