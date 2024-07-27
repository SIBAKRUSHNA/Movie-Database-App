//
//  Array+Extension.swift
//  Movie Database
//
//  Created by Siba Krushna Biswal on 27/07/24.
//

import Foundation

extension String {
    func separateYears() -> [String?] {
        let pattern = #"(\d{4})(?:–(\d{4})?)?"#
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        if let match = regex?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            let nsString = self as NSString
            let startYearRange = match.range(at: 1)
            let startYearString = nsString.substring(with: startYearRange)
            let startYear = startYearString
            var endYear: String? = nil
            let endYearRange = match.range(at: 2)
            if endYearRange.location != NSNotFound {
                let endYearString = nsString.substring(with: endYearRange)
                endYear = endYearString
            }
            return [startYear, endYear]
        }
        return []
    }
}
