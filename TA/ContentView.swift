//
//  ContentView.swift
//  TA
//
//  Created by Artem Leschenko on 09.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    var VM = GraphViewModel()
    
    @State var city1 = ""
    @State var city2 = ""
    @State var showCity = false
    @State var showSheet = false
    
    @State var showAlert = false
    @State var texalert = ""
    
    
    var body: some View {
        ScrollView{
        VStack{
            Text("Код написав студент групи ІС-23 Лещенко Артем (за участі Хараман Аліни та Фіголь Владислави)\n\nГрупа №5\n\nКількість ребер графу: 15\nКількість вершин: 11").padding()
                .foregroundColor(Color(.label).opacity(0.6))
                .background(Color(.systemGray5))
                .cornerRadius(12)
            
            
            
            
                VStack(alignment: .leading) {
                    HStack{Text("Ознайомитись з каталогом маршруту")
                        Image(systemName: "chevron.down").rotationEffect(.degrees(showCity ? 180 : 0))
                            .animation(.easeInOut(duration: 0.3), value: showCity)
                        
                    }
             
                    
                    if showCity{
                        Divider()
                        Text("1) \"Київська політехніка\"\n2) \"Червоний університет\"\n3) \"Золоті ворота\"\n4) \"Фонтан на Хрещатику\"\n5) \"Лядські ворота\"\n6) \"Софія київська\"\n7) \"Михайлівський собор\"\n8) \"Андріївська церква\"\n9) \"Музей однієї вулиці\"\n10) \"Фунікулер\"\n11) \"Національна філармонія\"")
                    }
                }.frame(maxWidth: .infinity, alignment: .leading).padding()
                .foregroundColor(Color(.label).opacity(0.6))
                .background(Color(.systemGray5))
                .cornerRadius(12)
                .padding(10)
                .onTapGesture {
                    withAnimation {
                            showCity.toggle()
                        }
                    }
            
            
                
            
            
            Spacer().frame(height: 30)
            
            VStack(alignment: .leading) {
                Text("Старт").font(.headline).fontWeight(.light).foregroundColor(Color(.label).opacity(0.75))
                
                HStack{
                    TextField("Bведіть місце старту", text: $city1).autocorrectionDisabled(true).textInputAutocapitalization(.never)
                }
                    
                Divider()
            }.padding(.horizontal, 10).padding(.bottom, 15)
            
            Spacer().frame(height: 20)
            
            VStack(alignment: .leading) {
                Text("Фініш").font(.headline).fontWeight(.light).foregroundColor(Color(.label).opacity(0.75))
                
                HStack{
                    TextField("Bведіть місце фінішу", text: $city2).autocorrectionDisabled(true).textInputAutocapitalization(.never)
                }
                    
                Divider()
            }.padding(.horizontal, 10)
            
            Spacer().frame(height: 50)
            
            Button {
                if city1 == city2{
                    
                    texalert = "Ти вже на цьому місці"
                    showAlert.toggle()
                    
                }else if (VM.dict.keys.contains(city1) || VM.graph.keys.contains(city1))
                        && (VM.dict.keys.contains(city2) || VM.graph.keys.contains(city2))  {
                    showSheet.toggle()
                } else { texalert = "Щось ти не те вводиш";
                    showAlert.toggle() }
                
            } label: {
                Text("Розрахунок найкращого маршруту").foregroundColor(Color(.label).opacity(0.5)).frame(width: UIScreen.main.bounds.width - 120).padding()
                    .fontWeight(.bold)
                
            }.background(Color(.systemGray5))
                .clipShape(Capsule())
                .padding(.top, 45)
                .shadow(radius: 5)

            Spacer().frame(height: 50)
        }
            
        }.sheet(isPresented: $showSheet) {
            Graph(city1: $city1, city2: $city2)
        }
        .alert(texalert, isPresented: $showAlert) {
            Text("OK")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

