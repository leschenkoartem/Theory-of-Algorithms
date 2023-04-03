//
//  YearView.swift
//  TA
//
//  Created by Artem Leschenko on 03.04.2023.
//

import SwiftUI

struct YearView: View{
    
    var currentYear: YearOfMarks
    var priviousYear: YearOfMarks
    
    var body: some View {
        VStack{
            Text(String(currentYear.year))
                .font(.title)
                .padding(.vertical, 4)
                .padding(.bottom, -3)
            Divider()
            
            ForEach(currentYear.marks.sorted(by: { $0.key < $1.key }), id: \.key) { student in
                HStack {
                    Text(student.key)
                        .fontWeight(.medium)
                    Spacer()
                    
                    let privious = priviousYear.marks
                    if privious.keys.contains(student.key){
                        
                        let razn = (student.value - privious[student.key]!)
                        Text("\(student.value) ") +
                        Text(razn < 0 ? "(": "(+")
                            .foregroundColor(razn < 0 ? .red: .green) +
                        Text("\(razn))")
                            .foregroundColor(razn < 0 ? .red: .green)
                    } else {
                        Text("\(student.value)")
                    }
                    
                }
            }
            .padding(4)
            .padding(.horizontal, 10)
            
            Spacer().frame(height: 5)
        }.frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
            .padding(.vertical, 3)
            
    }
}


struct YearView_Previews: PreviewProvider {
    static var previews: some View {
        YearView(currentYear: YearOfMarks(year: 2019,
                                           marks: ["Leschenko": 12,
                                                   "Haraman" : 2,
                                                   "Nifontov": 7]), priviousYear: YearOfMarks(year: 2019,
                                                                                                marks: ["Leschenko": 10,
                                                                                                        "Haraman" : 3,
                                                                                                        "Nifontov": 1]))
    }
}
