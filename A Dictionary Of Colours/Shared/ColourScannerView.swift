//
//  ColourScannerView.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 27/09/25.
//

import SwiftUI

struct ColourScannerView: View {
    @Binding var selectedColor: Color
    @Binding var selectedImage: Image?
    var body: some View {
        ZStack {
            VStack {	
//                ColorPicker("Choose a Color:", selection: $selectedColor)
                Spacer()
//                if(selectedImage != nil) {
//                    PixelPickerView(colourSelected: $selectedColor, selectedImage: selectedImage!)
//                }
                FileImporterView(displayImage: $selectedImage)

            }.padding(.horizontal)
        }
    }
}
