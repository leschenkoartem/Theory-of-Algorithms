//
//  Button.swift
//  TA
//
//  Created by Artem Leschenko on 12.03.2023.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(Color(.label).opacity(0.5))
            .multilineTextAlignment(.center)
            .padding()
            .padding(.horizontal, 40)
            .fontWeight(.bold)
            .background(Color(.systemGray5))
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}



