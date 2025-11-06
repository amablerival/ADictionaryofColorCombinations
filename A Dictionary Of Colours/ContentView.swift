//
//  ContentView.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 25/08/23.
//

import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    // Selected Color state, should be shared across some views
    @State var selectedColor: Color = ColourService.getRandomColour()
    
    // Picker State for Toolbar Item
    @State var showPicker: Bool = false
    // Checks for current theme color: dark | light
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            NavigationStack {
                // This is just the App's title
                Text("A Dictionary Of Color Combinations".uppercased())
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                // Selected color status bar
                SelectedColorStatusBar(selectedColor: $selectedColor)
                
                Text("Closest Colors")
                    .font(.subheadline)
                    .padding()
                Spacer()
                ScrollView(.vertical) {
                    // Lazy Grid
                    ColourLazyGridView(selectedColor: $selectedColor)
                }
//                .gesture(
//                    DragGesture(minimumDistance: 30, coordinateSpace: .scrollView)
//                        .onChanged { gesture in
//                            let height = gesture.translation.width
//                            print("drag? \(height)")
//                        }
//                )
                
                
            }
            .padding(.zero)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
//                        Button {
////                            showPicker.toggle()
//                        } label: {
//                            Image(systemName: "list.triangle")
//                                .foregroundStyle( colorScheme == .dark ? Color.white : Color.black )
//                        }
                    Button {
                        showPicker.toggle()
                    } label: {
                        Image(systemName: "photo.artframe.circle.fill")
                            .foregroundStyle( colorScheme == .dark ? .white : .black )
                    }
                }
            }
        }.imageColorPicker(showPicker: $showPicker, color: $selectedColor)
    }
}


// MARK: MIGRATE
struct SelectedColorStatusBar: View {
    @Binding var selectedColor: Color
    var size: CGFloat = 80.0
    var body: some View {
        VStack {
           Rectangle()
                .fill(selectedColor)
                .frame(width: size * 4.6, height: size)
                .onTapGesture {
                    selectedColor = ColourService.getRandomColour()
                }
//                    Text("Selected: \(selectedColor.description)")
//                       .font(.footnote)
//                       .multilineTextAlignment(.center)
        }
    }
}

@available(iOS 17.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
