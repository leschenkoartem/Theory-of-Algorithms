//
//  MainView2_3.swift
//  TA
//
//  Created by Artem Leschenko on 07.04.2023.
//

import SwiftUI

//Код написаний на швидку руку, тому ні про які патерни не може йті мова
struct StackView3: View {
    @Environment(\.dismiss) var dismiss
    @State var isError = false
    @State var name = ""
    @State var score = ""
    @State var isFull = false
    @State var groups = [Stack(maxSize: 5, name: "Іс23", year: 2023)]
    @State var grupa = ""
    var body: some View {
            VStack {
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
                
                ScrollView {
                    ForEach(groups.reversed(), id: \.name) { groupa in
                        let first = groupa.years.first?.students ?? []
                        let last = groupa.years.last?.students ?? []
                        let firstMarks = first.count > 0 ? Double(first.reduce(0) { $0 + $1.grade }) / Double(first.count) : 0.0
                        let secondMarks = last.count > 0 ? Double(last.reduce(0) { $0 + $1.grade }) / Double(last.count) : 0.0
                        VStack {
                        Text("\(groupa.name)")
                        Text("За перший рік: \(String(format: "%.2f", firstMarks))")
                        Text("За перший рік: \(String(format: "%.2f", secondMarks))")
                        Text("Різниця: \(String(format: "%.2f", secondMarks - firstMarks))")
                            .font(.title)
                        Divider()
                        
                            ForEach(groupa.years.reversed(), id: \.year){ year in
                                VStack {
                                    Text(String(year.year))
                                    ForEach(year.students.reversed(), id: \.name) { student in
                                        VStack {
                                            Text("\(student.name)")
                                            Text("Grade: \(student.grade)")
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                    }
                                }
                            }
                        }.padding()
                            .background(.blue.opacity(0.2))
                        .cornerRadius(12)
                        .padding()
                    }
                }
                Divider()
                VStack {
                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Score", text: $score)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    HStack{
                        Button {
                            isFull.toggle()
                        } label: {
                            Text("Додати нову групу")
                        }.padding()
                        .background(Color(.systemGray5))

                        Button{
                            if name != "" &&
                                Int(score) != nil {
                                let newStudent = Student(name: name, grade: Double(score) ?? 0)
                                groups.last?.years.last?.push(newStudent)
                                name = ""
                                score = ""
                            } else {
                                isError.toggle()
                            }
                        } label: {
                            Text("Add Student")
                        }.padding()
                            .background(Color(.systemGray5))

                        Button {
                            if ((groups.last?.years.last?.pop()) != nil) {
                                if ((groups.last?.years.last?.students.isEmpty) != nil)
                                    && ((groups.last?.years.count)! > 1){
                                    groups.last?.years.removeLast()
                                }
                                name = "k"
                                name = ""
                            }
                        } label: {
                            Text("Delete")
                        }.padding()
                            .background(Color(.systemGray5))

                    }
                    HStack{
                        Button {
                            groups.last?.years.append(Year(maxSize: groups.last?.years.last?.maxSize ?? 23, year: (groups.last?.years.last?.year ?? 20) + 1))
                            name = "k"
                            name = ""
                        } label: {
                            Text("Почати новий рік")
                        }.padding()
                            .background(Color(.systemGray5))
                    }
                }
            }.alert(isPresented: $isError) {
                Alert(title: Text("Hормально працюй"), message: Text("Дурачок"), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $isFull) {
                AddingView3(students: $groups)
            }
            .alert(isPresented: $isError) {
                Alert(title: Text("Hормально працюй"), message: Text("Дурачок"), dismissButton: .default(Text("OK")))
            }
        }
}

struct MainView2_3_Previews: PreviewProvider {
    static var previews: some View {
        StackView3()
    }
}






