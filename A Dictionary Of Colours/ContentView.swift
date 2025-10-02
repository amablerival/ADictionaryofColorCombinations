//
//  ContentView.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 25/08/23.
//

import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    let data: [ColourModel] = ColourService.getData()
    let size: CGFloat = 80.0
    let rowSize = 4
    let colSize = 24
    @State var selectedColor: Color = getColour(by: "Yellow")
    @State var selectedImage: Image?
    @State var showPicker: Bool = false
    var body: some View {
        let closestColours = selectedColor.findClosestColours(by: colSize)
        ZStack() {
            
        }
        .imageColorPicker(showPicker: $showPicker, color: $selectedColor)
        ZStack {
            NavigationStack {
                Text("A Dictionary Of Color Combinations")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                VStack {
                    Button {
                        showPicker.toggle()
                    } label: {
                        Text("Show Image Color Picker")
                    }
                   Rectangle()
                        .fill(selectedColor)
                       .frame(width: size / 2, height: size / 2)
                    Text("\(selectedColor.description)")
                       .font(.footnote)
                       .multilineTextAlignment(.center)
                       .frame(maxWidth: size)
                }
                Text("Closest Colors")
                    .font(.subheadline)
                    .padding()
                Spacer()
                ScrollView(.vertical) {
                    Grid {
                        ForEach(0..<closestColours.count - 1, id: \.self) { row in
                            GridRow {
                                ForEach(0..<rowSize, id: \.self) { column in
                                    let index: Int = (row * rowSize) + column
                                    if (index <= closestColours.count - 1) {
                                        let datum = closestColours[index]
                                        NavigationLink {
                                            ColourCombinationView(colour: datum)
                                        } label: {
                                            VStack {
                                               Rectangle()
                                                    .fill(datum.normalized)
                                                   .frame(width: size, height: size)
                                                   .overlay(Text("\(String(format: "%.2f", datum.distance  ?? 1.0) )").font(.subheadline).foregroundStyle(Color.gray))
                                               Text("\(datum.name)")
                                                   .font(.footnote)
                                                   .multilineTextAlignment(.center)
                                                   .frame(maxWidth: size + 10.0)
                                               Spacer()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
//                Spacer()
            }.padding(.zero)
            
        }.imageColorPicker(showPicker: $showPicker, color: $selectedColor)
    }
}

//struct ColoursClosestLabel: View {
//    let size: CGFloat = 80.0
//    @State var colour: ColourModel
////    @State var colour: Color
////    @State var name: String
//    var body: some View {
//        VStack {
//           Rectangle()
//                .fill(colour.normalized)
//               .frame(width: size, height: size)
//            Text("\(colour.name)")
//               .font(.footnote)
//               .multilineTextAlignment(.center)
//               .frame(maxWidth: size + 10.0)
//           Spacer()
//        }
//    }
//}


@available(iOS 17.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
