//
//  TAApp.swift
//  TA
//
//  Created by Artem Leschenko on 09.03.2023.
//

import SwiftUI

@main
struct TAApp: App {
    
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
                ContentView()
        }.onChange(of: scenePhase) { newValue in
            switch newValue{
            case .background:
                print("background")
            case .active:
                print("active")
            case .inactive:
                print("inactive")
            @unknown default:
                print("Unknown error")
            }
        }
    }
}



extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
