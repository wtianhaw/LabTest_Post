//
//  Constant.swift
//  LabTest
//
//  Created by Wong Tian Haw on 06/07/2022.
//

import Foundation
import UIKit

struct Constant {
    static var SEARCH_KEYWORD: String = ""
    
    static var BASE_URL_STRING: String = "https://dev.codezero.app"
    
    static var DEMO_ACCESS_TOKEN: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjZjOGM3Mzk3YTA5Mzc3YWE4ZDI0YjVlZDZmNGU1MmViMGE4MmRjYTA1N2RmNTViZjFhOWVmY2Q2ZjczMmJkZGIwNTk4MzBmMzY1OTdmNWZmIn0.eyJhdWQiOiIyIiwianRpIjoiNmM4YzczOTdhMDkzNzdhYThkMjRiNWVkNmY0ZTUyZWIwYTgyZGNhMDU3ZGY1NWJmMWE5ZWZjZDZmNzMyYmRkYjA1OTgzMGYzNjU5N2Y1ZmYiLCJpYXQiOjE2NDUzNjc5OTEsIm5iZiI6MTY0NTM2Nzk5MSwiZXhwIjoxNjc2OTAzOTkxLCJzdWIiOiI5OSIsInNjb3BlcyI6WyIqIl19.DreN8FMxLy-YzPaaO3KBsyMZeqs0vkhAuz2OKpEUgKJGLWon8Ov0EnHLavl_huRCtPWd-gMXZLMM78Dw8o-qn-VuQRmKG4cZMdBx5DprokpnXvidHcpSeixNwPeHZLhQdo1RxjkyTNErL9NukPX45899CASS-yTmSY7CnB2OOOjgf2ppqreCSiLaw-TX3RBLrFvD8NOjEUJk8alen-Kp9fb6cGPABEP1VB9d4y5H5mD_KuOYdBprw9ZsABqMGPv552ARpfMHL-fKHTytTDkSS5LyunQhb_LHdvqQnlXhf5Cbu_9FVUlVCXcZe_Rf6XRSB9x6KW4qOqW-9yftYQ5qF4cEK3iDkeaxf_8spo20eRmxJwx1LW4pFxMNdhtdj5aNyIBuGMO8uzpr0lJ0Pr0vcvxtoaZlcq9Y5PigpSho6KM5zV1e2PEirKAX11EYJlzx_x56P14bAwRyU-4EGHxWayAt4dy8NGFKueUeEvgfdrUXokhz0A7J5Dy18U7L6OwBvPBSKnX60KW1EOAa7wPOliXrH3eKO-qPgnEuC33GbByuITfDNEn-pDeExO0_ENuxRgFNXl70ImBCulTz84l61dXT4KQ5wBsXaQaQG-7n2OuFQef5cdxWsENiGRPdjYQ3M5V-Z-b7eHX7JHVXxAeXXwBNlLS02Ie2G4sQji95y8s"
    
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
