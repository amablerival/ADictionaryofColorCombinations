//
//  FileService.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 29/09/25.
//

import SwiftUI
import PhotosUI // For specifying allowed content types

struct FileImporterView: View {
    @State private var selectedItem: PhotosPickerItem?
    @Binding var displayImage: Image?
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images) {
            VStack {
                Text("Select Image")
            }
        }.onChange(of: selectedItem) {
            
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    displayImage = Image(uiImage: uiImage)
                    print("IMAGE?")
                } else {
                    print("Failed to load image")
                }
            }
        }
    }
    
}


struct PixelPickerView: View {
    @State private var cursor = CGPoint.zero  // Drag position
    @Binding var colourSelected: Color  // Pixel Color
    @State private var x = 0                   // Scaled drag x
    @State private var y = 0                   // Scaled drag y
    @State var selectedImage: Image
    let frameHeight = 200.0
    let frameWidth = UIScreen.screenWidth * (UIScreen.screenWidth / 200.0)
    var body: some View {
        VStack(alignment: .center) {
            GeometryReader { g in
                ZStack(alignment: .center) {
                    let diameter: CGFloat = min(g.size.width, g.size.height)
                    HStack(alignment: .center) {
                        Spacer()
                        selectedImage
                            .resizable()
                            .scaledToFit()
                            .overlay(alignment: .center) {
                                cursor(diameter: diameter)
                            }
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged {
                                        cursor = $0.location
                                    }
                                    .onEnded {_ in
                                        colourAtOffset(diameter: diameter)
                                    }
                            ).clipped()
                        Spacer()
                    }.clipped()
                }
            }
            Spacer()
            ZStack {
                Text("x: \(x), y: \(y)")
            }
        }
    }
    
    private func colourAtOffset(diameter: CGFloat) {
        Task {
            if let cgi = ImageRenderer(content: selectedImage).cgImage {
                if let dp = cgi.dataProvider,
                   let pixelData = dp.data {
                    let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

                    x = Int(CGFloat(cgi.width) * cursor.x / diameter)
                    y = Int(CGFloat(cgi.height) * cursor.y / diameter)
                    let pixelInfo: Int = (cgi.bytesPerRow * y) + x * 4
                    if cgi.bitmapInfo.contains(.byteOrderDefault) {
                        let r = CGFloat(data[pixelInfo + 0]) / CGFloat(255)
                        let g = CGFloat(data[pixelInfo + 1]) / CGFloat(255)
                        let b = CGFloat(data[pixelInfo + 2]) / CGFloat(255)
                        let a = CGFloat(data[pixelInfo + 3]) / CGFloat(255)
                        colourSelected = Color(red: r, green: g, blue: b, opacity: a)
                    } else {
                        colourSelected = .brown // Brown for debug, should be `nil`
                    }
                }
            }
        }
    }
    
    private func cursor(diameter: CGFloat) -> some View {
        let r = diameter / 2
        let wee = CGFloat(2.5)
        let p = Path { p in
            p.move(to: CGPoint(x: 0, y: r))
            p.addLine(to: CGPoint(x: r - wee, y: r))
            p.move(to: CGPoint(x: r + wee, y: r))
            p.addLine(to: CGPoint(x: 2 * r, y: r))
            
            p.move(to: CGPoint(x: r, y: 0))
            p.addLine(to: CGPoint(x: r, y: r - wee))
            p.move(to: CGPoint(x: r, y: r + wee))
            p.addLine(to: CGPoint(x: r, y: 2 * r))
        }
        
        return p.stroke(Color.black, lineWidth: 3)
            .offset(cursorOffset(diameter: diameter))
    }
    
    private func cursorOffset(diameter: CGFloat) -> CGSize {
        CGSize(width: cursor.x - (diameter / 2),
               height: cursor.y - (diameter / 2))
    }
}
