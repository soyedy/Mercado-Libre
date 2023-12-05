//
//  Extensions.swift
//  Mercado Libre
//
//  Created by John Edward Narvaez Londono on 30/11/23.
//

import Foundation

extension String {
  func Localized(comment: String? = nil) -> String {
    return NSLocalizedString(self, comment: comment ?? "")
  }
}

extension Double {
    var formattedWithInteger: String {
        let integerPart = Int(self)
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(integerPart) : String(self)
    }
}
