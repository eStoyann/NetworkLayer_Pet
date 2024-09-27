//
//  Extension+Error.swift
//  NetworkLayer_Pet
//
//  Created by Evgeniy Stoyan on 23.09.2024.
//

import Foundation

extension Error {
    private var nsError: NSError {
        self as NSError
    }
    public var code: Int {
        nsError.code
    }
    public var isURLRequestCancelled: Bool {
        code == NSURLErrorCancelled
    }
}
