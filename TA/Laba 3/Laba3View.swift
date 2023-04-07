//
//  Laba3View.swift
//  TA
//
//  Created by Artem Leschenko on 07.04.2023.
//

import SwiftUI

struct Laba3View: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            VStack(spacing: 60) {
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Text("\(Image(systemName: "arrow.backward")) Назад")
                            .padding(.leading, 10)
                            .foregroundColor(Color(.label).opacity(0.7))
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                Spacer()
                NavigationLink {
                    DictView3().navigationBarBackButtonHidden(true)
                } label: {
                    Text("Звичайні словарі")
                }.buttonStyle(CustomButtonStyle())
                
                
                NavigationLink {
                    StackView3().navigationBarBackButtonHidden(true)
                } label: {
                    Text("Стек")
                }.buttonStyle(CustomButtonStyle())
                Spacer()
            }.padding()
        }
    }
}

struct Laba3View_Previews: PreviewProvider {
    static var previews: some View {
        Laba3View()
    }
}
