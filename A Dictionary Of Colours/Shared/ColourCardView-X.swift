//
//  ColorCardView.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 25/08/23.
//

//import SwiftUI
//import UIKit

//struct ColourCardView: View {
//    @State var colour: ColourModel
//    var body: some View {
//        let (name, normalized, cmykLabel, combinationsLabel) = {
//            return ($0.name, $0.normalized, $0.cmykLabel, $0.combinationsLabel)
//        } (colour)
//        HStack {
//            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
//                .fill(normalized)
//                .frame(width: 100.0, height: 100.0)
//            Spacer()
//            CardLabelView(title: name, titleFont: .headline, content: cmykLabel, contentFont: .custom("subheadline", size: 16.0))
//            Spacer()
//            CardLabelView(title: "Combinations", titleFont: .headline, content: combinationsLabel)
//        }.frame(maxWidth: .infinity, maxHeight: 100.0)
//            .padding(.horizontal)
//    }
//}
//
//
//
//struct CardLabelView: View {
//    @State var title: String
//    @State var titleFont: Font = .title3
//    @State var content: String
//    @State var contentFont: Font = .subheadline
//    let col = ColourService.getColour(by: "Yellow Orange")
//    var body: some View {
//        VStack(alignment: .center) {
//            Text(title).font(titleFont).foregroundStyle(.gray)
//            Text(content).font(contentFont).foregroundColor(ColourService.getColour(by: "Deep Indigo"))
//        }
//    }
//}
