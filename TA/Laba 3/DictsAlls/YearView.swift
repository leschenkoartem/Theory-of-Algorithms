//
//  YearView.swift
//  TA
//
//  Created by Artem Leschenko on 03.04.2023.
//

import SwiftUI

struct YearView: View{
    
    var vm: YearViewModel
    var currentYear: YearOfMarks
    
    var body: some View {
        
        VStack{
            
            Text(String(currentYear.year))
                .font(.title)
                .padding(.vertical, 4)
                .padding(.bottom, -3)
            Divider()
            
            vm.avarageOfAllGroup()
                .padding(.horizontal, 10)
                .fontWeight(.bold)
                .opacity(0.75)
            
            ForEach(Array(currentYear.marks.sorted(by: { $0.key < $1.key }).enumerated()), id: \.1.key) { index, student in
                vm.avarageOfStudent(student: student, index: index)
            }
            .padding(4)
            .padding(.horizontal, 10)
            
            Spacer().frame(height: 5)
        }
        .frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
            .padding(.vertical, 3)
        
            
    }
}


struct YearView_Previews: PreviewProvider {
    static var previews: some View {
        YearView( vm: YearViewModel(priviousYear: YearOfMarks(year: 2019,
                                                              marks: ["Leschenko": 12,
                                                                      "Haraman" : 2,
                                                                      "Nifontov": 9]), currentYear: YearOfMarks(year: 2019,
                                                                                                                marks: ["Leschenko": 10,
                                                                                                                        "Haraman" : 3,
                                                                                                                        "Nifontov": 1])), currentYear: YearOfMarks(year: 2019,
                                           marks: ["Leschenko": 12,
                                                   "Haraman" : 2,
                                                   "Nifontov": 9]))
    }
}
