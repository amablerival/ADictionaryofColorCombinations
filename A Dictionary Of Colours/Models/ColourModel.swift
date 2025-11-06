//
//  ColourModel.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 25/08/23.
//

import Foundation
import SwiftUI

struct ColourModel: ColourProtocol {
    let id = UUID()
    let name: String
    let combinations: [Int]
    let swatch: Int
    let cmyk: [Int]
    let lab: [Double]
    let rgb: [Int]
    let hex: String
    var distance: Double?
    var distanceLabel: String?
    var index: Int?
    var comb: Int?
    
    var normalized: Color {
        return Color(
            red: normalizeBy(rgb[0]),
            green: normalizeBy(rgb[1]),
            blue: normalizeBy(rgb[2])
        )
    }
    
    var resolved: Color.Resolved {
        return Color.Resolved(
            red: Float(normalizeBy(rgb[0])),
            green: Float(normalizeBy(rgb[1])),
            blue: Float(normalizeBy(rgb[2]))
        )
    }
    
    var cmykLabel: String {
        return "C\(self.cmyk[0]) M\(self.cmyk[1]) Y\(self.cmyk[2]) K\(self.cmyk[3])"
    }
    
    var combinationsLabel: String {
        return combinations.description
            .replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")
    }
}

func normalizeBy(_ colour: Int) -> Double {
    return Double(colour) / 255.0
}
