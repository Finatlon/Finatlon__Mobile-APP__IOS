//
//  ContentView.swift
//  Finatlon
//
//  Created by Дмитрий Канский on 11.12.2022.
//

import SwiftUI
import iPhoneNumberField

struct ContentView: View {
    @State var CurrentScreen = 2
    var body: some View {
        switch CurrentScreen {
        case 0:
            LoginView(CurrentScreen: $CurrentScreen)
        case 1:
            MainView()
        case 2:
            RegisterView(CurrentScreen: $CurrentScreen)
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
    @Binding var CurrentScreen: Int
    @State private var lastname: String = ""
    @State private var givenname: String = ""
    @State private var middlename: String = ""
    @State private var password: String = ""
    @State private var dob: Date = Date.now
    @State private var phone: String = ""
    var body: some View {
        NavigationView {
        VStack(alignment: .center, spacing: 20.0) {
            //Text("Личные данные").font(.title)
            VStack(alignment: .leading) {
                Text("Фамилия")
                TextField("Фамилия", text: $lastname)
                    .textContentType(.familyName)
                Text("Имя")
                TextField("Имя", text: $givenname).textContentType(.givenName)
                Text("Отчество")
                TextField("Отчество", text: $middlename).textContentType(.familyName)
                DatePicker("Дата рождения", selection: $dob, displayedComponents: [.date])
                Text("Телефон")
                iPhoneNumberField(nil, text: $phone).defaultRegion("RU")
                    .flagHidden(false)
                    .flagSelectable(true)
                    .prefixHidden(false)
            }.textFieldStyle(.roundedBorder).padding()
            HStack(alignment: .center) {
                Button("Назад", action: {self.CurrentScreen = 0})
                    .padding(.trailing)
                            NavigationLink {
                                Register2()
                            } label: {
                                Text("Далее")
                            }.navigationTitle("Личные данные")
                    .padding(.leading).buttonStyle(.borderedProminent)
                        }
            }
        }
    }
}

struct Register2: View {
    @State private var coutry: String = ""
    @State private var fed_district: String = ""
    @State private var region: String = ""
    @State private var postal_code: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            HStack() {
                Text("Страна")
                Spacer()
                Picker("", selection: $coutry) {
                    Text("Россия").tag("Россия")
                    Text("Не Россия").tag("Не Россия")
                    Text("Юпитер").tag("Юпитер")
                    Text("???").tag("???")
                    Text("Парагвай").tag("Парагвай")
                }
            }
            HStack() {
                Text("Федеральный округ")
                Spacer()
                Picker("", selection: $fed_district) {
                    Text("Центральный").tag("Центральный")
                    Text("Не центральный").tag("Не центральный")
                    Text("Плутон").tag("Плутон")
                    Text("???").tag("???")
                    Text("Где-то").tag("Где-то")
                }
            }
            HStack() {
                Text("Субъект РФ").padding(.trailing)
                Spacer()
                Picker("", selection: $region) {
                    Text("Москва").tag("Москва")
                    Text("Не Москва 😱").tag("Не Москва 😱")
                    Text("Челябинская область").tag("Челябинская область")
                    Text("???").tag("???")
                    Text("Ханты-Мансийский Автономный Округ — Югра").tag("Ханты-Мансийский Автономный Округ — Югра")
                }
            }
            Text("Почтовый индекс")
            TextField("Почтовый индекс", text: $postal_code)
                .textContentType(.postalCode)
        }.textFieldStyle(.roundedBorder)
        .padding()
        NavigationLink {
            Register3()
        } label: {Text("Далее")}
        .navigationTitle("Место проживания")
        .buttonStyle(.borderedProminent)
    }
}

struct Register3: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            
        }
        NavigationLink {
            MainView()
        } label: {Text("Далее")}
        .navigationTitle("Место проживания")
        .buttonStyle(.borderedProminent)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
