//
//  ColourCombinationModel.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 05/11/25.
//

import Foundation

struct ColourCombination: Identifiable, Hashable, Comparable {
    static func < (lhs: ColourCombination, rhs: ColourCombination) -> Bool {
        lhs.id > rhs.id
    }
    let id: String
    let combinations: [ColourModel]
}
