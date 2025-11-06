//
//  ColourChapterView.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 04/11/25.
//

import SwiftUI

struct ColourChapterView: View {
    var id: String
    var colour: ColourModel
    var combinations: [ColourModel]
    // Checks for current theme color: dark | light
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack {
            Text(id)
                .frame(width: 40.0)
                .accentColor(colorScheme == .dark ? .white : .black)
            VStack(spacing: 0) {
                Rectangle()
                    .fill(colour.normalized)
                    .frame(width: .infinity, height: 18.0)
                Spacer()
                    .frame(width: .infinity, height: 3.7)
                ForEach(combinations, id: \.self) { sw in
                    Rectangle()
                        .fill(sw.normalized)
                        .frame(width: .infinity, height: 18.0)
                    Spacer()
                        .frame(width: .infinity, height: 3.7)
                }
            }
        }
    }
}
