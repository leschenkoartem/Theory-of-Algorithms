//
//  TextArea.swift
//  TA
//
//  Created by Artem Leschenko on 12.03.2023.
//

import Foundation
import SwiftUI


struct CustomTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .foregroundColor(Color(.label).opacity(0.6))
            .background(Color(.systemGray5))
            .cornerRadius(12)
            .padding(5)
            
    }
}







extension View {
    func customTextStyle() -> some View {
        self.modifier(CustomTextStyle())
    }
}
