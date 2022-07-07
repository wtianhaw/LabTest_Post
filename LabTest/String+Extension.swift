//
//  String+Extension.swift
//  LabTest
//
//  Created by Wong Tian Haw on 06/07/2022.
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func msgTimestampToDateTimeString() -> String? {
        if let doubleConvert = Double(self) {
            let date = Date(timeIntervalSince1970: doubleConvert)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.timeZone = .current
            dateFormatter.dateFormat = "dd MMM yyyy"
            let localDate = dateFormatter.string(from: date)
            return localDate
        }
        return nil
    }
}
