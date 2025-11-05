//
//  ColourCombinationBottomView.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 04/11/25.
//

import SwiftUI

struct ColourCombinationBottomView: View {
    var combinedColors: [ColourCombination]
    var colour: ColourModel
    var body: some View {
        Text("\(combinedColors.count) COMBINATIONS").font(.subheadline).foregroundColor(.gray)
        ScrollView {
            ForEach(combinedColors, id: \.self) { datum in
                NavigationLink {
                    VStack(spacing: 0) {
                        ColourSwatchView(id: datum.id, swatches: datum.combinations, colour: colour, size: .infinity)
                    }.listRowInsets(EdgeInsets())
                } label: {
                    ColourChapterView(id: datum.id, colour: colour.normalized, combinations: datum.combinations)
                        .padding(.bottom)
                }.listRowInsets(EdgeInsets())
            }
        }
    }
}
