//
//  AddingView3.swift
//  TA
//
//  Created by Artem Leschenko on 07.04.2023.
//

import SwiftUI

struct AddingView3: View {
    @Binding var students: [Stack]
    @Environment(\.dismiss) var dismiss
    @State var isError = false
    @State var name = ""
    @State var max = ""
    @State var year = ""
    var body: some View {
        VStack{
            Spacer()
            TextField("Назва", text: $name).textFieldStyle(.roundedBorder)
            TextField("кількість учінів", text: $max).textFieldStyle(.roundedBorder)
            TextField("Рік початку", text: $year).textFieldStyle(.roundedBorder)
            Spacer().frame(height: 60)
            Button {
                if students.count > 1{
                    students.removeLast()
                    dismiss()
                }
            } label: {
                Text("Remove last group")
            }.padding()
                .background(Color(.systemGray5))

            Button {
                if name != "" && Int(year) != nil && Int(max) != nil {
                    students.append(Stack(maxSize: Int(max)!, name: name, year: Int(year)!))
                    dismiss()
                } else {
                    isError.toggle()
                }
            } label: {
                Text("Add group")
            }.padding()
                .background(Color(.systemGray5))
            Spacer()
        }
        .background(Color(.systemGray6))
        .alert(isPresented: $isError) {
            Alert(title: Text("Hормально працюй"), message: Text("Дурачок"), dismissButton: .default(Text("OK")))
        }
    }
}

struct AddingView3_Previews: PreviewProvider {
    @State static var f = [Stack]()
    static var previews: some View {
        AddingView3(students: $f)
    }
}
