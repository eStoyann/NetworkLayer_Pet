//
//  Extension+UITableView.swift
//  NetworkRouter
//
//  Created by Evgeniy Stoyan on 09.09.2024.
//  Copyright © 2024 com.gmail@sev1001. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func register<Cell>(_ cellType: Cell.Type) where Cell: UITableViewCell {
        register(cellType, forCellReuseIdentifier: Cell.id)
    }
}
//MARK: - Generic dequeueReusableCell methods
extension UITableView {
    private func dequeueReusableCell<Cell>() -> Cell where Cell: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.id) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(Cell.id)")
        }
        return cell
    }
    func dequeueReusableCell<Cell>(for indexPath: IndexPath?) -> Cell where Cell: UITableViewCell {
        if let indexPath {
            guard let cell = dequeueReusableCell(withIdentifier: Cell.id, for: indexPath) as? Cell else {
                fatalError("Could not dequeue cell with identifier: \(Cell.id)")
            }
            return cell
        }
        return dequeueReusableCell()
    }
    
    
}
