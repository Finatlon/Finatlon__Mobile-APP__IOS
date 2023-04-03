//
//  ContentView.swift
//  Finatlon
//
//  Created by Дмитрий Канский on 11.12.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Финатлон")
                .font(.title)
            TextField("Логин", text: <#T##Binding<String>#>)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
