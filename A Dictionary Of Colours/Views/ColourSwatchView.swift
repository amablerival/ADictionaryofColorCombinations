//
//  ColourSwatchView.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 27/09/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct ColourSwatchView: View {
    var id: String
    var swatches: [ColourModel]
    var colour: ColourModel?
    var size: CGFloat  = 40.0
    var body: some View {
        Text(id)
            .font(.title)
            .bold()
            .padding(.bottom)
        if (colour != nil) {
            ColourSingleSwatchView(colour: colour!, size: size)
        }
        ForEach(swatches, id: \.self) { datum in
            ColourSingleSwatchView(colour: datum, size: size)
        }
    }
}


struct ColourSingleSwatchView: View {
    var colour: ColourModel
    var size: CGFloat = 40.0
    var body: some View {
        let contrast = Color.black.getContrast(with: colour.resolved)
        Rectangle()
            .fill(colour.normalized)
            .frame(maxWidth: size, maxHeight: size)
            .overlay {
                VStack {
                    VStack {
                        Text("\(colour.name)")
                            .font(.title)
                            .foregroundStyle(contrast)
                        Text("No. \(colour.index ?? 0)")
                            .font(.subheadline)
                            .foregroundStyle(contrast.secondary)
                    }.padding(.vertical)
                    HStack(alignment: .center, spacing: 40.0) {
                        Text("\(colour.cmykLabel)")
                            .font(.headline)
                            .foregroundStyle(contrast)
                            .onTapGesture() {
                                UIPasteboard.general.setValue(colour.cmykLabel,
                                forPasteboardType: UTType.plainText.identifier)
                            }
                        Text("\(colour.hex)")
                            .font(.headline)
                            .foregroundStyle(contrast)
                            .onTapGesture() {
                                UIPasteboard.general.setValue(colour.hex,
                                forPasteboardType: UTType.plainText.identifier)
                            }
                            
                    }
                }
            }
    }
}
