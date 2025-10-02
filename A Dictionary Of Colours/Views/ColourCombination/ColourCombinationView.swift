//
//  ColorCombinationView.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 25/08/23.
//

import SwiftUI

// MARK: MAIN VIEW
struct ColourCombinationView: View {
    @State var colour: ColourModel
    var size: CGFloat  = 40.0
    var body: some View {
        let (name, normalized, hex) = {
            return ($0.name, $0.normalized, $0.hex)
        } (colour)
        let combinedColors = ColourService.combine(colour)
        VStack {
            NavigationStack {
                ColourCombinationTopView(name: name, colour: normalized, hex: hex)
                Spacer()
                ColourCombinationBottomView(combinedColors: combinedColors, colour: colour)
            }
            Spacer()
        }
    }
}
