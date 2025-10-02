//
//  ColourSwatchView.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 27/09/25.
//

import SwiftUI

struct ColourSwatchView: View {
    @State var id: String? = UUID().uuidString
    @State var swatches: [ColourModel]
    @State var colour: ColourModel?
    @State var size: CGFloat  = 40.0
    var body: some View {
        if(id != nil && id!.count < UUID().uuidString.count) {
            Text(id!).frame(width: 40.0)
        }
        if (colour != nil) {
            Rectangle()
                .fill(colour!.normalized)
                .frame(width: size, height: size)
        }
        ForEach(swatches, id: \.id) { datum in
            Rectangle()
                .fill(datum.normalized)
                .frame(width: size, height: size)
        }
    }
}
