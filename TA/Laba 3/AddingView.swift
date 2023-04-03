//
//  AddingView.swift
//  TA
//
//  Created by Artem Leschenko on 03.04.2023.
//

import SwiftUI

struct AddingView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var allGroups: [String : [YearOfMarks]]
    @State var grupa = "ІС-23"
    @State var name = ""
    @State var mark = ""
    @State var year = 2022
    @State var listToAdd = [String : Int]()

    
    var body: some View {
        VStack{
            Spacer().frame(height: 30)
            HStack{
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }.padding(.horizontal, 20)
                    .foregroundColor(Color(.label).opacity(0.75))
                    .fontWeight(.bold)
            }
           
            Picker("Обрати існуючу групу", selection: $grupa) {
                ForEach(allGroups.keys.sorted(), id: \.self) { group in
                    Text(group)
                        .tag(group)
                }
            }.frame(width: 150)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                            
            HStack{
                VStack(alignment: .leading) {
                    Text("Група").font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color(.label).opacity(0.75))
                    HStack{
                        TextField("Bведіть місце старту", text: $grupa).autocorrectionDisabled(true).textInputAutocapitalization(.words)
                    }
                    Divider()
                }.padding()
                Divider().frame(height: 90)
                Picker("", selection: $year) {
                            ForEach(1998 ..< 2050) { year in
                                Text(String(year)).tag(year)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 90)
            }.foregroundColor(Color(.label).opacity(0.75))
            
            Divider()
            HStack{
                Text("Прізвище:")
                VStack{
                    TextField("Прізвище", text: $name).autocorrectionDisabled(true).textInputAutocapitalization(.words)
                    Divider()
                }
                Text("Оцінка:")
                VStack{
                    TextField("Оцінка", text: $mark).autocorrectionDisabled(true).textInputAutocapitalization(.words)
                        .keyboardType(.numberPad)
                        
                    Divider()
                }
            }.padding(.horizontal)
                .padding(.bottom, 10)
                .foregroundColor(Color(.label).opacity(0.75))
            
            HStack{
                Button {
                    listToAdd[name] = Int(mark)
                } label: {
                    Text("Додати")
                }.foregroundColor(Color(.label).opacity(0.5))
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.horizontal, 30)
                    .fontWeight(.bold)
                    .background(Color(.systemGray5))
                    .clipShape(Capsule())
                    .shadow(radius: 5)
                    .padding(.trailing, 10)
                Button {
                    if !allGroups.keys.contains(grupa){
                        allGroups[grupa] = [YearOfMarks(year: year, marks: listToAdd)]
                    } else {
                        allGroups[grupa]!.append(YearOfMarks(year: year, marks: listToAdd))
                    }
                    dismiss()
                } label: {
                    Text("Завершити")
                }.foregroundColor(Color(.label).opacity(0.5))
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.horizontal, 10)
                    .fontWeight(.bold)
                    .background(Color(.systemGray5))
                    .clipShape(Capsule())
                    .shadow(radius: 5)
            }
            
            List {
                ForEach(listToAdd.keys.sorted(), id: \.self) { student in
                    HStack{
                        Text(student)
                        Spacer()
                        Text(String(listToAdd[student]!))
                    }
                }.onDelete { indexSet in
                    for index in indexSet {
                        let student = Array(listToAdd.keys.sorted())[index]
                        listToAdd.removeValue(forKey: student)
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct AddingView_Previews: PreviewProvider {
    @State static var allGroups = ["ІС-23": [YearOfMarks(year: 2019, marks: ["Leschenko": 11, "Haraman" : 2, "Nifontov": 0]),
                               YearOfMarks(year: 2020, marks: ["Leschenko": 12, "Brunov": 20, "Haraman" : 2, "Nifontov": 0]), YearOfMarks(year: 2021, marks: ["Leschenko": 12, "Brunov": 15, "Haraman" : 2, "Nifontov": 0])],
                     "ІС-21": [YearOfMarks(year: 2019, marks: ["Leschenko": 2, "Haraman" : 4, "Nifontov": 1])],
                     "ІС-22": [YearOfMarks(year: 2019, marks: ["Leschenko": 15, "Haraman" : 2, "Nifontov": 4])]
    ]
    static var previews: some View {
        AddingView(allGroups: $allGroups)
    }
}
