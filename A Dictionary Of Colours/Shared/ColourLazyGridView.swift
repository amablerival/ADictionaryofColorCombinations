//
//  ColourLazyGridView.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 27/09/25.
//

import SwiftUI

struct ColourLazyGridView: View {
    // Set the sizes for the 2D Grid
    let rowSize = 4
    let colSize = 24
    let size: CGFloat = 80.0
    
    @Binding var selectedColor: Color
    
    var body: some View {
        // Declares new array of GridItems for 2D LazyGrid
        let columns = Array(repeating: GridItem(.flexible(minimum: CGFloat(colSize))), count: rowSize)
        // Finds a list of closest colors to the selected color
        let closestColours = selectedColor.findClosestColours(by: colSize)
        /**LAZY GRID**/
        LazyVGrid(columns: columns) {
            ForEach(closestColours, id: \.self) { colour in
                NavigationLink {
                    ColourCombinationView(colour: colour)
                } label: {
                    ColourBasicInfoView(colour: colour, index: closestColours.firstIndex(where: { w in
                        w.name == colour.name
                    }) ?? colour.combinations.count)
                }
            }
        }
        /**LAZY GRID**/
    }
}
