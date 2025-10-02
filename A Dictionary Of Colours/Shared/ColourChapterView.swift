//
//  ColourChapterView.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 04/11/25.
//

import SwiftUI

struct ColourChapterView: View {
    var id: String
    var colour: Color
    var combinations: [ColourModel]
    var body: some View {
        HStack {
            Text(id)
                .frame(width: 40.0)
                .accentColor(.gray)
            VStack(spacing: 0) {
                Rectangle()
                    .fill(colour)
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
