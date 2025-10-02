//
//  ColourScrollView.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 27/09/25.
//

import SwiftUI

struct ColourScrollView: View {
    @State var data: [ColourModel]
    @State var orientation: Axis.Set = .vertical
    var body: some View {
        ScrollView(orientation) {
            ForEach(data) { datum in
                NavigationLink {
                    ColourCombinationView(colour: datum)
                } label: {
                    ColourCardView(colour: datum)
                }
            }
        }
    }
}
