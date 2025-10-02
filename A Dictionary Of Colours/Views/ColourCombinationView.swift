//
//  ColorCombinationView.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 25/08/23.
//

import SwiftUI

struct ColourCombinationView: View {
    @State var colour: ColourModel
    let data: [ColourModel] = ColourService.getData()
    var body: some View {
        let (name, normalized, hex) = {
            return ($0.name, $0.normalized, $0.hex)
        } (colour)
        let combinedColors = ColourService.combine(colour, with: data)
        VStack {
            NavigationStack {
                Rectangle()
                    .fill(normalized)
                    .frame(width: .infinity, height: 200.0)
                Text(name)
                    .font(.title)
                Text(hex.replacingOccurrences(of: "#", with: ""))
                    .font(.footnote)
                    .foregroundColor(.gray)
                Spacer()
                Text("Combinations").font(.subheadline).foregroundColor(.gray)
                ScrollView {
                    ForEach(combinedColors, id: \.self) { datum in
                        NavigationLink {
                            VStack(spacing: 0) {
                                ColourSwatchView(id: datum.id, swatches: datum.combinations, colour: colour, size: .infinity)
                            }.listRowInsets(EdgeInsets())
                        } label: {
                            HStack {
                                ColourSwatchView(id: datum.id, swatches: datum.combinations, colour: colour)
                            }
                        }.listRowInsets(EdgeInsets())
                    }
                }
            }
            Spacer()
        }
    }
}
