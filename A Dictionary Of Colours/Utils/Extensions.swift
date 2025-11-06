//
//  Extensions.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 27/09/25.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

extension Color {
//    Examples of custom colors
//    static let customTeal = Color(red: 0.1, green: 0.7, blue: 0.6)
//    static let brandAccent = Color(hue: 0.7, saturation: 0.8, brightness: 0.9)
    static let primary = ColourService.getData()[3].normalized
    
    /// distance = sqrt((r2 - r1)^2 + (g2 - g1)^2 + (b2 - b1)^2)
    /// Returns the Euclidean distance between this color and another color.
    /// The colors are treated as points in a 3D RGB color space.
    func euclideanDistance(to otherColor: Color) -> Double {
        // Get the RGB components of the current color
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        UIColor(self).getRed(&r1, green: &g1, blue: &b1, alpha: &a1)

        // Get the RGB components of the other color
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        UIColor(otherColor).getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        // Calculate the squared differences for each component
        let dr = (r2 - r1) * (r2 - r1)
        let dg = (g2 - g1) * (g2 - g1)
        let db = (b2 - b1) * (b2 - b1)

        // Return the square root of the sum of squared differences
        return sqrt(Double(dr + dg + db))
    }
    
    
    func findClosestColours(by amount: Int = 3) -> [ColourModel] {
        let data: [ColourModel] = ColourService.getData().enumerated().map() {(i, m) in
            var copy = m
            copy.index = i + 1
            return copy
        }
        let sorted = data.sorted(by: { (a: ColourModel, b: ColourModel) -> Bool in
            a.normalized.euclideanDistance(to: self) < b.normalized.euclideanDistance(to: self)
        }).map(){m in
            var copy = m
            copy.distance = copy.normalized.euclideanDistance(to: self)
            copy.distanceLabel = "\(String(format: "%.2f", copy.distance  ?? 1.0) )"
            return copy
        }
        return Array(sorted[0..<amount])
    }
    
//    func findClosestColours<T: ColourProtocol>(by amount: Int = 3) -> [T] {
//        let data: [ColourModel] = ColourService.getData()
//        let sorted = data.sorted(by: { (a: ColourModel, b: ColourModel) -> Bool in
//            a.normalized.euclideanDistance(to: self) < b.normalized.euclideanDistance(to: self)
//        })
//        return Array(sorted[0..<amount]) as! [T]
//    }
    
    // LUMINANCE
    func getLuminance(with color: Color.Resolved) -> Float {
        let r = 0.2126 * color.red
        let g = 0.7152 * color.green
        let b = 0.0722 * color.blue
        return r + g + b
    }
    func getContrast(with color: Color.Resolved) -> Color {
        return self.getLuminance(with: color)  < 0.33 ? Color.white : Color.black
    }
}


extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}


extension UIImage {
    func averageColor() -> UIColor? {
        guard let ciImage = CIImage(image: self) else { return nil }

        let extentVector = CIVector(x: ciImage.extent.origin.x,
                                    y: ciImage.extent.origin.y,
                                    z: ciImage.extent.size.width,
                                    w: ciImage.extent.size.height)

        let filter = CIFilter.areaAverage()
        filter.inputImage = ciImage
        filter.extent = extentVector.cgRectValue    

        guard let outputImage = filter.outputImage else { return nil }

        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        var bitmap = [UInt8](repeating: 0, count: 4)
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255.0,
                       green: CGFloat(bitmap[1]) / 255.0,
                       blue: CGFloat(bitmap[2]) / 255.0,
                       alpha: CGFloat(bitmap[3]) / 255.0)
    }
}
