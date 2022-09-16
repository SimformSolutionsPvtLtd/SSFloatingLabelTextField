//
//  Extension.swift
//  SSFloatingLabelTextField
//
//  Created by Mohammed Hanif on 22/06/21.
//

import Foundation

extension String {
    
    func isValidRegex(regex: String?) -> Bool {
        guard let regex = regex else {
            return !self.isEmpty
        }
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", regex)
        return passwordPred.evaluate(with: self)
    }
    
    /// Phone Number Format
    /// - Parameters:
    ///   - mask: Mask String
    /// - Returns: Formatted String
    func format(with mask: String) -> String {
        let numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
