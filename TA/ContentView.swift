//
//  ContentView.swift
//  TA
//
//  Created by Artem Leschenko on 09.03.2023.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.scenePhase) var scenePhase
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                VStack{
                    Text("Код написав студент групи ІС-23")
                    +
                    Text(" Лещенко Артем").fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .green : .indigo)
                        
                    +
                    Text(" (за участі")
                    +
                    Text(" Хараман Аліни").fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .green : .indigo)
                    +
                    Text(" та ")
                    +
                    Text(" Фіголь Владислави").fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .green : .indigo)
                    +
                    Text(")\n\nГрупа №5 ")
                        
                }.customTextStyle()
                    
                
                Spacer().frame(height: 40)
                Text("Вибір завдань для роботи")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.label).opacity(0.7))
                
                Spacer().frame(height: 80)

                NavigationLink {
                    MainView2()
                        .navigationBarBackButtonHidden(true)
                                        } label: {
                    Text("Пошук найкоротшого шляху")
                }.buttonStyle(CustomButtonStyle())
                    .padding()
                
                NavigationLink {
                    Laba3View()
                        .navigationBarBackButtonHidden(true)
                                        } label: {
                    Text("Список Школоти")
                }.buttonStyle(CustomButtonStyle())
                    .padding()
                
                Spacer()
            }.blur(radius: scenePhase == .inactive ? 10 : 0)
        }.onTapGesture {
            UIApplication.shared.endEditing()
        }
        


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

