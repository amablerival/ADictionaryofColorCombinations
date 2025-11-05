//
//  CustomColorPickerView.swift
//  A Dictionary Of Colours
//
//  Created by Rival on 30/09/25.
//

import SwiftUI

// MARK: Making extension to call Image Color Picker
extension View {
    func imageColorPicker(showPicker: Binding<Bool>, color: Binding<Color>) -> some View {
        return self
            .fullScreenCover(isPresented: showPicker) {
            } content: {
                Helper(showPicker: showPicker, color: color)
            }
    }
}

// MARK: Custom View for Color Picker
struct Helper: View {
    @Binding var showPicker: Bool
    @Binding var color: Color
    @State var selectedImage: Image?
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                
                // MARK: Image Picker View
                GeometryReader {proxy in
                    let size = proxy.size
                    VStack(spacing: 12) {
                        if (selectedImage != nil) {
                            selectedImage!
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height, alignment: .center)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .contentShape(Rectangle())
                HStack {
                    FileImporterView(displayImage: $selectedImage)
                    CustomColorPicker(color: $color)
                        .frame(alignment: .topLeading)
                        .frame(width: 250, height: 50)
                        .scrollDisabled(true)
                        .clipped()
                        .offset(x: 20)
                }
                ZStack(alignment: .top) {
                    // Displaying the Selected Color
                    Rectangle()
                        .fill(color)
                        .frame(height: 90)
                }
            }
            .ignoresSafeArea(.container, edges: .bottom)
            .navigationTitle("Image Color Picker")
            .navigationBarTitleDisplayMode(.inline)
        // MARK: Close Button
            .toolbar {
                Button("Close") {
                    showPicker.toggle()
                }
            }
            
        }
    }
}


struct CustomColorPicker: UIViewControllerRepresentable {
    // MARK: Picker Values
    @Binding var color: Color
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> some UIColorPickerViewController {
        let picker = UIColorPickerViewController()
        picker.supportsAlpha = false
        picker.selectedColor = UIColor(color)
        // Connecting Delegate
        picker.delegate = context.coordinator
        // Removing Title
        picker.title = ""
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    // MARK: Delegate Methods
    class Coordinator: NSObject, UIColorPickerViewControllerDelegate {
        var parent: CustomColorPicker
        
        init(parent: CustomColorPicker) {
            self.parent = parent
        }
        
        func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
            // updating color
            parent.color = Color(viewController.selectedColor)
        }
        
        func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
            parent.color = Color(color)
        }
    }
    
}
