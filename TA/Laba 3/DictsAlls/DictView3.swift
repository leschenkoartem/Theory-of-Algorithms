//
//  MainView3.swift
//  TA
//
//  Created by Artem Leschenko on 03.04.2023.
//

import SwiftUI

struct DictView3: View {
    
    
    @State var showDialog = false
    @Environment(\.dismiss) var dismiss
    @State var yeartodel = YearOfMarks(year: 2000)
    @State var allGroups = ["ІС-23": [YearOfMarks(year: 2019, marks: [
        "Вершигора": 9,
        "Дашков": 11,
        "Деундяк": 6,
        "Добруцький": 7,
        "Єркін": 5,
        "Лещенко": 1,
        "Марченко": 8,
        "Маток": 6
    ]),
        YearOfMarks(year: 2020, marks: [
        "Вершигора": 7,
        "Габрись": 4,
        "Гілевич": 9,
        "Дашков": 6,
        "Деундяк": 8,
        "Добруцький": 5,
        "Єркін": 10,
        "Жиріков": 2,
        "Коваль": 11,
        "Коцюбинська": 3,
        "Красовський": 8,
        "Лещенко": 6,
        "Марченко": 1,
        "Маток": 12
    ]),
                                      YearOfMarks(year: 2021, marks: [
        "Вершигора": 6,
        "Габрись": 7,
        "Гілевич": 9,
        "Дашков": 5,
        "Деундяк": 2,
        "Добруцький": 8,
        "Єркін": 4,
        "Жиріков": 10,
        "Коваль": 3,
        "Коцюбинська": 7,
        "Красовський": 1,
        "Лещенко": 6,
        "Марченко": 11,
        "Маток": 5
    ])]
    ]
    @State var isFull = false
    
    @State var grupa = "ІС-23"
    var body: some View {
        VStack{
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
            
            Picker("", selection: $grupa) {
                ForEach(allGroups.keys.sorted(), id: \.self) { group in
                    Text(group)
                        .tag(group)
                }
            }.frame(width: 150)
                .background(Color(.systemGray5))
                .cornerRadius(12)
                .padding(.bottom, 5)
            
            ZStack{
                
                if !allGroups[grupa]!.isEmpty{
                    ScrollView {
                        ForEach(allGroups[grupa]!.sorted { $0.year > $1.year }, id: \.year) { yearOfMarks in
                            let previousYear = allGroups[grupa]?.filter({ $0.year < yearOfMarks.year }).sorted(by: { $0.year > $1.year }).first ?? YearOfMarks(year: 2019, marks: [:])
                            YearView(vm: YearViewModel(priviousYear: previousYear, currentYear: yearOfMarks),
                                     currentYear: yearOfMarks).onTapGesture {
                                yeartodel = yearOfMarks
                                showDialog.toggle()
                            }
                        }
                        Spacer().frame(height: 120)
                    }
                } else {
                    Text("А нема, всьо").font(.title)
                        .fontWeight(.bold)
                        .opacity(0.5)
                }
                
                VStack{
                    Spacer()
                    Button {
                        isFull.toggle()
                    } label: {
                        Text("Додати")
                    }.buttonStyle(CustomButtonStyle())
                        .padding(10)
                    Spacer().frame(height: 40)
                }
            }
            Spacer()
        }
        .confirmationDialog("Видаляємо \(String(yeartodel.year))?", isPresented: $showDialog, titleVisibility: .visible) {
            
            Button {
                if let index = allGroups[grupa]?.firstIndex(where: { $0.year == yeartodel.year }) {
                    allGroups[grupa]?.remove(at: index)
                }
            } label: {
                Text("Tak")
            }

            
            Button(role: .cancel) {
                showDialog.toggle()
            } label: {
                Text("Ні")
            }
        }
        .sheet(isPresented: $isFull) {
            AddingView(YearsToShow: (allGroups[grupa]?.max(by: { $0.year < $1.year }))!, maingrup: grupa, allGroups: $allGroups)
        }
    }
}

struct MainView3_Previews: PreviewProvider {
    static var previews: some View {
        DictView3()
    }
}

