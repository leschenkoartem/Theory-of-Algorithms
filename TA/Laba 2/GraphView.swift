//
//  Graph.swift
//  TA
//
//  Created by Artem Leschenko on 09.03.2023.
//

import SwiftUI

struct GraphView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @State var showList = false
    @State var wList = 0.0
    @State var textList = ""
    
    
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
            //Якщо вертикально
            if verticalSizeClass == .regular{
                
                Image("1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity,  maxHeight:  verticalSizeClass == .compact ? .infinity: 180)
                    .cornerRadius(12)
                    .shadow(radius: 12, y: 20)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView{
                    VStack{
                        VStack{
                            Text("Шлях з місця ")
                            +
                            Text("\"\(city1)\"").foregroundColor(colorScheme == .dark ? .green : .indigo)
                                .fontWeight(.bold)
                            +
                            Text(" до місця ")
                            +
                            Text("\"\(city2)\"").foregroundColor(colorScheme == .dark ? .green : .indigo)
                                .fontWeight(.bold)
                        }.padding()
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
            }else{
                //якщо горизонтально
                ZStack {
                    Image("1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity,  maxHeight:  verticalSizeClass == .compact ? .infinity: 180)
                        .cornerRadius(12)
                        .shadow(radius: 12, y: 20)
                        .edgesIgnoringSafeArea(.all)
                    
                    
                    HStack(spacing:0){
                        Spacer().frame(width: showList ? 20: 0)
                            VStack{
                                Spacer().frame(height: 30)
                                Text(textList)
                                    .foregroundColor(Color(.label).opacity(0.6))
                                    .animation(.easeInOut(duration: 0.5), value: showList)
                                
                            }.frame(maxWidth: wList, maxHeight: .infinity)
                            .background(Color(.systemGray5).opacity(showList ? 1 : 0))
                        
                        
                        VStack{
                            Spacer().frame(height: 40)
                            HStack{
                                Button {
                                    withAnimation {
                                        
                                        wList = wList == 0.0 ? 300.0: 0.0
                                        textList = textList == "" ? (bellmanF.0+"\n\n\nДовжина маршруту: "+bellmanF.1)+"m" : ""
                                        showList.toggle()
                                    }
                                    
                                } label: {
                                    Image(systemName: "chevron.right")
                                        .font(.title2)
                                        .rotationEffect(.degrees(showList ? 180 : 0))
                                        .animation(.easeInOut(duration: 0.3), value: showList)
                                        .padding()
                                }.foregroundColor(Color(.label).opacity(0.5))
                                    .fontWeight(.bold)
                                    .background(Color(.systemGray5))
                                
                                Spacer()
                            }
                            
                            Spacer()
                        }
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
        GraphView(city1: $a, city2: $b)
    }
}
