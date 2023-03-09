//
//  Graph.swift
//  TA
//
//  Created by Artem Leschenko on 09.03.2023.
//

import SwiftUI

struct Graph: View {
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var VM = GraphViewModel()
    @Binding var city1:String
    @Binding var city2:String
    @State private var scale: CGFloat = 1.0
    
    
    var bellmanF: (String, String){
        get { return VM.bellmanFord(start: city1, end: city2)}
    }
    
    var deikstri: (String, String){
        get {return VM.deikstri(start: city1, end: city2)}
    }
    
    var body: some View {
        VStack {
            
            
            
                Image("1")
                    .resizable()
                    .aspectRatio(contentMode: verticalSizeClass == .compact ? .fill: .fit)
                    .frame(maxWidth: .infinity,  maxHeight:  verticalSizeClass == .compact ? .infinity: 180)
                    .cornerRadius(12)
                    .shadow(radius: 12, y: 20)
                .edgesIgnoringSafeArea(.all)
                

            if verticalSizeClass == .regular{
                ScrollView{
                    VStack{
                        Text("Шлях з місця \"\(city1)\" до місця \"\(city2)\"").padding()
                            .foregroundColor(Color(.label))
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemGray5))
                            .clipShape(Capsule())
                        
                            .shadow(radius: 5)
                            .padding()
                        
                        
                        VStack(spacing: 20){
                            Text("Aлгоритм Bellman-Ford").foregroundColor(Color(.label).opacity(0.75)).fontWeight(.bold)
                            Text(bellmanF.0).padding()
                                .foregroundColor(Color(.label).opacity(0.75))
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .shadow(radius: 2)
                            
                            
                            Text("Його довжина складатиме \(bellmanF.1)m").padding()
                                .foregroundColor(Color(.label))
                                .frame(maxWidth: .infinity)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .shadow(radius: 2)
                            
                        }.padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(12)
                            .padding()
                            .shadow(radius: 2)
                        
                        VStack(spacing: 20){
                            Text("Aлгоритм Дейкстри").foregroundColor(Color(.label).opacity(0.75)).fontWeight(.bold)
                            Text(deikstri.0).padding()
                                .foregroundColor(Color(.label).opacity(0.75))
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .shadow(radius: 2)
                            
                            
                            Text("Його довжина складатиме \(deikstri.1)m").padding()
                                .foregroundColor(Color(.label))
                                .frame(maxWidth: .infinity)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .shadow(radius: 2)
                            
                        }.padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(12)
                            .padding()
                            .shadow(radius: 2)
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

struct Graph_Previews: PreviewProvider {
    @State static var a = "4"
    @State static var b = "11"
    static var previews: some View {
        Graph(city1: $a, city2: $b)
    }
}
