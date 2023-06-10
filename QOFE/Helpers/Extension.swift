//
//  Extentions.swift
//  QOFE
//
//  Created by rifqitriginandri on 05/03/23.
//

import Foundation
import SwiftUI


extension Double{
    
    var clean: String{
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension Image {

    func data(url:URL) -> Self {

        if let data = try? Data(contentsOf: url) {

            return Image(uiImage: UIImage(data: data)!).resizable()

        }

        return self

            .resizable()

    }

}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
//    func customDialog(
//        presentationManager: DialogPresentation
//    ) -> some View {
//        self.modifier(CustomDialog(presentationManager: presentationManager))
//    }

}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}



private extension UIScrollView {
    override open var clipsToBounds: Bool {
        get { false }
        set {}
    }
}

