//
//  Extension+String.swift
//  NetworkRouter
//
//  Created by Evgeniy Stoyan on 09.09.2024.
//  Copyright © 2024 com.gmail@sev1001. All rights reserved.
//

import Foundation

extension String {
    func capitalizeOnlyFirstLetter() -> String {
        let words = components(separatedBy: " ")
        if words.count > 1 {
            let capitalizedFirstWordLetter = words.first!.capitalized
            let textWithoutFirstWord = dropFirst()
            let text = capitalizedFirstWordLetter+textWithoutFirstWord
            return text
        }
        return isEmpty ? self : capitalized
    }
}
