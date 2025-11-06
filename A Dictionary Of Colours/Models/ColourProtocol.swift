//
//  ColourProtocol.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 05/11/25.
//

import Foundation

protocol ColourProtocol: Decodable, Identifiable, Hashable, Sendable {
    var id: UUID { get }
    var name: String { get }
    var combinations: [Int] { get }
    var swatch: Int { get }
    var cmyk: [Int] { get }
    var lab: [Double] { get }
    var rgb: [Int] { get }
    var hex: String { get }
    var distance: Double? { get set }
    var distanceLabel: String? { get set}
    var index: Int? { get set}
    var comb: Int? { get set }
}
