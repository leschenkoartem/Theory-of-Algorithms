//
//  MainView.swift
//  TA
//
//  Created by Artem Leschenko on 12.03.2023.
//

import SwiftUI


struct MainView2: View {
    
    @Environment(\.dismiss) var dismiss
    
    var VM = GraphViewModel()
    
    @State var city1 = ""
    @State var city2 = ""
    @State var showCity = false
    @State var showSheet = false
    
    @State var showAlert = false
    @State var texalert = ""
    @State var doptextalert = ""
    
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
            
            
            Text("Кількість ребер графу: 15\nКількість вершин: 11")
                .customTextStyle()
                .padding(.horizontal, 5)
                
                VStack(alignment: .leading) {
                    HStack { Text("Ознайомитись з каталогом маршруту")
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down").rotationEffect(.degrees(showCity ? 180 : 0))
                            .animation(.easeInOut(duration: 0.3), value: showCity)
                            
                    }
            
                    if showCity{
                        Divider()
                        
                        Text("1) \"Київська політехніка\"\n2) \"КНУ\"\n3) \"Золоті ворота\"\n4) \"Фонтан на Хрещатику\"\n5) \"Лядські ворота\"\n6) \"Софійський собор\"\n7) \"Михайлівський собор\"\n8) \"Андріївська церква\"\n9) \"Музей однієї вулиці\"\n10) \"Фунікулер\"\n11) \"Національна філармонія\"")
                    }
                }.customTextStyle()
                .padding(.horizontal, 5)
                .onTapGesture {
                    withAnimation {
                            showCity.toggle()
                        }
                    }
            
            Spacer().frame(height: showCity ? 10: 80)
            
            VStack(alignment: .leading) {
                
                
                Text("Старт").font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(Color(.label).opacity(0.75))
                
                HStack{
                    TextField("Bведіть місце старту", text: $city1).autocorrectionDisabled(true).textInputAutocapitalization(.words)
                }
                
                    
                Divider()
                
            }.padding(.horizontal, 10).padding(.bottom, 15)
            
            Spacer().frame(height: showCity ? 10: 20)
            
            VStack(alignment: .leading) {
                Text("Фініш").font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(Color(.label).opacity(0.75))
                
                HStack{
                    TextField("Bведіть місце фінішу", text: $city2)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.words)
                }
                    
                Divider()
            }.padding(.horizontal, 10)
            
            Spacer().frame(height: showCity ? 0: 90)
            
            Button {
                 if (VM.dict.keys.contains(city1) || VM.graph.keys.contains(city1))
                    && (VM.dict.keys.contains(city2) || VM.graph.keys.contains(city2))  {
                    
                     
                     if city1 == city2 {
                         
                         texalert = "Ти вже на цьому місці"
                         doptextalert = "Загубився трохи, розумію"
                         showAlert.toggle()
                     } else{
                         city1 = VM.dict[city1] ?? city1
                         city2 = VM.dict[city2] ?? city2
                         showSheet.toggle()
                         
                     }
                    
                    
                } else {
                    
                    texalert = "Щось ти не те вводиш"
                    doptextalert = "Такого місця немає"
                    showAlert.toggle()
                    
                }
                
            } label: {
                Text("Розрахунок найкращого маршруту")
                
            }.buttonStyle(CustomButtonStyle())
                .padding(.top, 45)
                .padding()

            Spacer()
        }
        
        //sheet
        .sheet(isPresented: $showSheet) {
            GraphView(city1: $city1, city2: $city2)
        }
        //alert
        .alert(isPresented: $showAlert) {
            Alert(title: Text(texalert), message: Text(doptextalert), dismissButton: .default(Text("OK")))
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView2()
    }
}
