//
//  ContentView.swift
//  Finatlon
//
//  Created by Дмитрий Канский on 11.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State var didLogin = false
    
    var body: some View {
            return Group {
                if didLogin {
                    MainView()
                } else {
                    LoginView(didLogin: $didLogin)
                }
                
            }
    }
}

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @Binding var didLogin: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            Text("Финатлон").font(.title)
            TextField("Имя пользователя (email)", text: $username).textInputAutocapitalization(.never).disableAutocorrection(true)
            SecureField(text: $password, prompt: Text("Пароль")) {Text("пароль")}.textInputAutocapitalization(.never).disableAutocorrection(true)
            Button("Войти", action: {self.didLogin = true}).buttonStyle(.borderedProminent)
            Button("Зарегистрироваться", action: {self.didLogin = true})
        }.textFieldStyle(.roundedBorder)
            .padding()
    }
}

struct MainView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(didLogin: $didLogin)
    }
}
*/
