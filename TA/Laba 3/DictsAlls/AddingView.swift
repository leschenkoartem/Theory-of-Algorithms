//
//  AddingView.swift
//  TA
//
//  Created by Artem Leschenko on 03.04.2023.
//

import SwiftUI

struct AddingView: View {
    
    var YearsToShow: YearOfMarks
    var maingrup: String
    
    @Environment(\.dismiss) var dismiss
    @Binding var allGroups: [String : [YearOfMarks]]
    @State var grupa = "ІС-23" 
    @State var name = ""
    @State var mark = ""
    @State var year = 2021
    @State var listToAdd = [String : Int]()
    @State var copy = true
    
    var body: some View {
        VStack {
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
            }.padding(.bottom, 5)
            
            
            Picker("Обрати існуючу групу", selection: $grupa) {
                ForEach(allGroups.keys.sorted(), id: \.self) { group in
                    Text(group).tag(group)
                }
            }.frame(width: 150)
                .background(Color(.systemGray5))
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
                Divider().frame(height: 60)
                
                Picker("", selection: $year) {
                    ForEach(1998 ..< 2050) { year in
                        Text(String(year)).tag(year)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 90)
                .onChange(of: year) { newValue in
                    if copy{
                        if let current = allGroups[grupa]?.first(where: { $0.year == year }){
                            listToAdd.removeAll()
                            for i in current.marks{
                                listToAdd[i.key] = i.value
                            }
                        }
                    }
                }
            }.foregroundColor(Color(.label).opacity(0.75))
            
            Toggle("Копіювати список:", isOn: $copy).padding(.horizontal, 70)
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
                    listToAdd[name.trimmingCharacters(in: .whitespaces)] = Int(mark)
                    if Int(mark) != nil {
                        name = ""
                        mark = ""
                    }
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
                        //Якщо вже є такий рік то оновлюємо
                        if allGroups[grupa]!.contains(where: { $0.year == year }) {
                            let index = allGroups[grupa]!.firstIndex(where: { $0.year == year })
                            allGroups[grupa]?.remove(at: index!)
                        }
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
                Button {
                    listToAdd.removeAll()
                } label: {
                    HStack{
                        Spacer()
                        Text("Очистити")
                        Spacer()
                    }
                }
                
                ForEach(listToAdd.keys.sorted(), id: \.self) { student in
                    HStack{
                        Text(student)
                        Spacer()
                        Text(String(listToAdd[student]!))
                    }.onTapGesture {
                        name = student
                        mark = String(listToAdd[student]!)
                    }
                }.onDelete { indexSet in
                    for index in indexSet {
                        let student = Array(listToAdd.keys.sorted())[index]
                        listToAdd.removeValue(forKey: student)
                    }
                }
            }
        }
        .onAppear(){
            year = YearsToShow.year + 1
            grupa = maingrup
            for element in YearsToShow.marks{
                listToAdd[element.key] = element.value
            }
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
        AddingView(YearsToShow: YearOfMarks(year: 2019, marks: ["wefcdx":23, "cqde": 234]), maingrup: "ІС-22", allGroups: $allGroups)
    }
}
