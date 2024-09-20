//
//  Post.swift
//  NetworkRouter
//
//  Created by Evgeniy Stoyan on 09.09.2024.
//  Copyright © 2024 com.gmail@sev1001. All rights reserved.
//

import Foundation

typealias Posts = Array<Post>
struct Post: Codable {
    let id: Int
    let title: String
    let body: String
}
extension Post: CustomStringConvertible {
    var description: String {
    """
    \n
    id: \(id);
    title: \(title);
    content: \(body).
    """
    }
}
