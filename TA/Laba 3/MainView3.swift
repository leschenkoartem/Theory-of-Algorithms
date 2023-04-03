//
//  MainView3.swift
//  TA
//
//  Created by Artem Leschenko on 03.04.2023.
//

import SwiftUI

struct MainView3: View {
    
    @Environment(\.dismiss) var dismiss
    @State var allGroups = ["ІС-23": [YearOfMarks(year: 2019, marks: ["Leschenko": 11, "Haraman" : 2, "Nifontov": 0]),
                               YearOfMarks(year: 2020, marks: ["Leschenko": 12, "Brunov": 20, "Haraman" : 2, "Nifontov": 0]), YearOfMarks(year: 2021, marks: ["Leschenko": 12, "Brunov": 15, "Haraman" : 2, "Nifontov": 0])]
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
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.bottom, 5)
            
            ZStack{
                ScrollView {
                    ForEach(allGroups[grupa]!.sorted { $0.year > $1.year }, id: \.year) { yearOfMarks in
                        if let previousYear = allGroups[grupa]?.filter({ $0.year < yearOfMarks.year }).sorted(by: { $0.year > $1.year }).first {
                            YearView(currentYear: yearOfMarks, priviousYear: previousYear)
                        } else {
                            YearView(currentYear: yearOfMarks, priviousYear: YearOfMarks(year: 2019, marks: [:]))
                        }
                    }
                }
                
                VStack{
                    Spacer()
                    Button {
                        isFull.toggle()
                    } label: {
                        Text("add")
                    }.buttonStyle(CustomButtonStyle())
                        .padding(10)
                    Spacer().frame(height: 40)
                }
            }
            Spacer()
        }.sheet(isPresented: $isFull) {
            AddingView(allGroups: $allGroups)
        }
    }
}

struct MainView3_Previews: PreviewProvider {
    static var previews: some View {
        MainView3()
    }
}

