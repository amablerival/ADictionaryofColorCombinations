//
//  ColourService.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 28/09/25.
//

import Foundation

class ColourService {
    static private let data: [ColourModel] = load("coloursData")
    static func getData() -> [ColourModel] {
        return data
    }
    static func combine(_ colour: ColourModel, with data: [ColourModel]) -> [ColourCombination] {
        let combinedItems = Array(Set(colour.combinations.map { comb in
            let filtered = data.filter{$0.combinations.contains(comb) && $0.name != colour.name}
            return filtered.map{m in ColourCombination(id: "\(comb)", combinations: filtered)}
        }.flatMap{$0})).sorted {$0.id < $1.id}
        return combinedItems.sorted {$0.combinations.count < $1.combinations.count}
    }
}


private func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}



