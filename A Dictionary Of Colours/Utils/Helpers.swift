//
//  Helpers.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 27/09/25.
//

import SwiftUI

func getColour(by name: String) -> Color {
    let data: [ColourModel] = ColourService.getData()
    let colour = data.filter { $0.name == name }.first ?? data[0]
    return colour.normalized
}
