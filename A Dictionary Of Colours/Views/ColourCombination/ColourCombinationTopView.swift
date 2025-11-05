//
//  ColourCombinationTopView.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 04/11/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct ColourCombinationTopView: View {
    var name: String
    var colour: Color
    var hex: String
    var body: some View {
        VStack {
            Rectangle()
                .fill(colour)
                .frame(width: .infinity, height: 200.0)
            Text(name)
                .font(.largeTitle)
                .bold()
                .foregroundStyle(colour)
            Text(hex)
                .font(.footnote)
                .foregroundColor(.gray)
                .onTapGesture(count: 2) {
                    UIPasteboard.general.setValue(hex,
                    forPasteboardType: UTType.plainText.identifier)
                }
        }
    }
}
