//
//  Extension+UIView.swift
//  NetworkRouter
//
//  Created by Evgeniy Stoyan on 09.09.2024.
//  Copyright © 2024 com.gmail@sev1001. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    enum Anchor {
        case top(NSLayoutYAxisAnchor, CGFloat = 0)
        case bottom(NSLayoutYAxisAnchor, CGFloat = 0)
        case leading(NSLayoutXAxisAnchor, CGFloat = 0)
        case trailing(NSLayoutXAxisAnchor, CGFloat = 0)
        case width(CGFloat)
        case height(CGFloat)
    }
    func constraint(toAnchor anchor: Anchor) {
        switch anchor {
        case let .top(axis, constant):
            topAnchor.constraint(equalTo: axis, constant: constant).isActive = true
        case let .bottom(axis, constant):
            bottomAnchor.constraint(equalTo: axis, constant: constant).isActive = true
        case let .leading(axis, constant):
            leadingAnchor.constraint(equalTo: axis, constant: constant).isActive = true
        case let .trailing(axis, constant):
            trailingAnchor.constraint(equalTo: axis, constant: constant).isActive = true
        case let .width(constant):
            widthAnchor.constraint(equalToConstant: constant).isActive = true
        case let .height(constant):
            heightAnchor.constraint(equalToConstant: constant).isActive = true
        }
    }
    func constraints(toAnchors anchors: Anchor...) {
        anchors.forEach(constraint)
    }
}
