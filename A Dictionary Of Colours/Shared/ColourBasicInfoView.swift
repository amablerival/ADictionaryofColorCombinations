//
//  ColourBasicInfoView.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 04/11/25.
//

import SwiftUI

struct ColourBasicInfoView: View {
    @State var colour: ColourModel
    @State var index: Int
    let size: CGFloat = 80.0
    var body: some View {
        let contrast = Color.black.getContrast(with: colour.resolved)
        VStack {
            Rectangle()
                .fill(colour.normalized)
                .frame(width: size, height: size)
                .overlay(
                    VStack {
                        Text("\(colour.index ?? 0)")
                            .font(.footnote)
                            .foregroundStyle(contrast.secondary)
                            .frame(
                                maxWidth: .greatestFiniteMagnitude,
                                alignment: .topLeading
                            )
                            .padding(.leading, 5.0)
                            .padding(.top, 2.5)
                        Text("\(colour.cmykLabel)")
                            .font(.subheadline)
                            .foregroundStyle(contrast)
                            .frame(
                                maxHeight: .greatestFiniteMagnitude,
                                alignment: .top
                            )
                    }
                )
            Text("\(colour.name)")
                .font(.footnote)
                .bold()
                .multilineTextAlignment(.center)
                .frame(maxWidth: size + 10.0)
                .accentColor(colour.normalized)
            Spacer()
        }
    }
}
