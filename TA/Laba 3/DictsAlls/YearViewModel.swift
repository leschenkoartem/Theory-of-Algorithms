//
//  YearViewModel.swift
//  TA
//
//  Created by Artem Leschenko on 05.04.2023.
//

import Foundation
import SwiftUI

class YearViewModel{
    
    var priviousYear: YearOfMarks
    var currentYear: YearOfMarks
    var previous: [String: Int] {
        get {return priviousYear.marks}
    }
    
    init(priviousYear: YearOfMarks, currentYear: YearOfMarks) {
        self.priviousYear = priviousYear
        self.currentYear = currentYear
    }
    
    func avarageOfAllGroup() -> HStack<TupleView<(Text, Spacer, Text, Text?)>> {
        return HStack{
            Text("Середня по групі:")
            Spacer()
            Text(String(format: "%.2f", Double(currentYear.marks.values.reduce(0, +)) / Double(currentYear.marks.count)))
            
            let averageCurrent = Double(currentYear.marks.values.reduce(0, +)) / Double(currentYear.marks.count)
            
            if let avaragePrevious = priviousYear.marks.isEmpty ? nil : Double(priviousYear.marks.values.reduce(0, +)) / Double(priviousYear.marks.count) {
                let diferenseOfGroup = averageCurrent - avaragePrevious
                Text("(\(diferenseOfGroup > 0 ? "+" : "")\(String(format: "%.2f", diferenseOfGroup)))")
                    .foregroundColor(diferenseOfGroup < 0 ? .red : .green)
            }
            
        }
    }
    
    func avarageOfStudent(student: Dictionary<String, Int>.Element,index: Int)
    -> HStack<TupleView<(some View, some View, Spacer, _ConditionalContent<TupleView<(some View, Text)>, Text>)>> {
        return HStack {
            Text("\(index + 1).")
                .fontWeight(.medium)
                .opacity(0.75)
            Text(student.key)
                .fontWeight(.medium)
                .opacity(0.75)
            
            Spacer()
            if previous.keys.contains(student.key) {
                let difference = student.value - previous[student.key]!
                Text("\(student.value) ")
                    .opacity(0.75)
                Text(difference < 0 ? "(\(difference))" : "(+\(difference))")
                    .foregroundColor(difference < 0 ? .red: .green)
            } else {
                Text("\(student.value)")
            }
        }
    }
}
