//
//  ContentView.swift
//  Finatlon
//
//  Created by Дмитрий Канский on 11.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State var CurrentScreen = 0
    var body: some View {
        switch CurrentScreen {
        case 0:
            LoginView(CurrentScreen: $CurrentScreen)
        case 1:
            MainView()
        case 2:
            RegisterView()
        default:
            LoginView(CurrentScreen: $CurrentScreen)
        }
    }
}

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @Binding var CurrentScreen: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            Text("Финатлон").font(.title)
            TextField("Имя пользователя (email)", text: $username).textInputAutocapitalization(.never).disableAutocorrection(true)
            SecureField(text: $password, prompt: Text("Пароль")) {Text("пароль")}.textInputAutocapitalization(.never).disableAutocorrection(true)
            Button("Войти", action: {self.CurrentScreen = 1}).buttonStyle(.borderedProminent)
            Button("Зарегистрироваться", action: {self.CurrentScreen = 2})
        }.textFieldStyle(.roundedBorder)
            .padding()
    }
}

struct MainView: View {
    var body: some View {
        Text("Вы вошли в аккаунт")
    }
}

struct RegisterView: View {
    @State private var lastname: String = ""
    @State private var givenname: String = ""
    @State private var middlename: String = ""
    @State private var password: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            Text("Фамилия")
            TextField("Фамилия", text: $lastname)
            Text("Имя")
            TextField("Имя", text: $givenname)
            Text("Отчество")
            TextField("Отчество", text: $middlename)
        }.textFieldStyle(.roundedBorder)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
