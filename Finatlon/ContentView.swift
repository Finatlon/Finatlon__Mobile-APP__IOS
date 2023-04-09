//
//  ContentView.swift
//  Finatlon
//
//  Created by Дмитрий Канский on 11.12.2022.
//

import SwiftUI
import iPhoneNumberField

struct ContentView: View {
    @State var CurrentScreen = 0
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
            TextField("Имя пользователя (email)", text: $username).textContentType(.emailAddress)
            SecureField(text: $password, prompt: Text("Пароль")) {Text("пароль")}.textContentType(.password)
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
        VStack(alignment: .center) {
            //Text("Личные данные").font(.title)
            VStack(alignment: .leading) {
                Text("Фамилия")
                TextField("Фамилия", text: $lastname)
                    .textContentType(.familyName)
                Text("Имя")
                TextField("Имя", text: $givenname).textContentType(.givenName)
                Text("Отчество")
                TextField("Отчество", text: $middlename).textContentType(.middleName)
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
        VStack(alignment: .leading) {
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
            TextField("Почтовый индекс", text: $postal_code).textContentType(.postalCode)
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
    @State private var town_type: String = ""
    @State private var town: String = ""
    @State private var str: String = ""
    @State private var bld: String = ""
    @State private var apt: String = ""
    @State private var is_village: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                Text("Тип населённого пункта")
                Spacer()
                Picker("", selection: $town_type) {
                    Text("Город").tag("Город")
                    Text("ПГТ").tag("ПГТ")
                    Text("???").tag("???")
                }
            }
            HStack() {
                Text("Населённый пункт")
                Spacer()
                Picker("", selection: $town) {
                    Text("Москва").tag("Москва")
                    Text("Город").tag("Город")
                    Text("Другой город").tag("Другой город")
                    Text("Город N").tag("Город N")
                }
            }
            Text("Адрес места жительства")
            TextField("Улица", text: $str).textContentType(.addressCity)
            HStack() {
                TextField("Дом", text: $bld).textContentType(.streetAddressLine1)
                TextField("Квартира", text: $apt).textContentType(.streetAddressLine2)
            }
            Toggle("Являюсь жителем сельской местности", isOn: $is_village)
        }.textFieldStyle(.roundedBorder).padding()
        NavigationLink {
            Register4()
        } label: {Text("Далее")}
        .navigationTitle("Место проживания")
        .buttonStyle(.borderedProminent)
    }
}

struct Register4: View {
    @State private var cls_year: Int = 0
    @State private var school: String = ""
    @State private var sch_phone: String = ""
    @State private var sch_postal_code: String = ""
    @State private var sch_country: String = ""
    @State private var sch_str: String = ""
    @State private var sch_bld: String = ""
    @State private var sch_email: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                Text("Класс обучения")
                Spacer()
                Picker("", selection: $cls_year) {
                    Text("2").tag(2)
                    Text("3").tag(3)
                    Text("4").tag(4)
                    Text("5").tag(5)
                    Text("6").tag(6)
                    Text("7").tag(7)
                    Text("8").tag(8)
                    Text("9").tag(9)
                    Text("10").tag(10)
                    Text("11").tag(11)
                }
            }
            Text("Телефон учреждения")
            iPhoneNumberField(nil, text: $sch_phone).defaultRegion("RU")
                .flagHidden(false)
                .flagSelectable(true)
                .prefixHidden(false)
            Text("Адрес учреждения")
            TextField("Почтовый индекс", text: $sch_postal_code).textContentType(.postalCode)
            HStack() {
                Text("Страна")
                Spacer()
                Picker("", selection: $sch_country) {
                    Text("Россия").tag("Россия")
                    Text("Не Россия").tag("Не Россия")
                    Text("Юпитер").tag("Юпитер")
                    Text("???").tag("???")
                    Text("Парагвай").tag("Парагвай")
                }
            }
            TextField("Улица", text: $sch_str).textContentType(.addressCity)
            TextField("Дом", text: $sch_bld).textContentType(.streetAddressLine1)
            Text("Email учреждения")
            TextField("Email", text: $sch_email).textContentType(.emailAddress)
        }.textFieldStyle(.roundedBorder).padding()
        NavigationLink {
            Register5()
        } label: {Text("Далее")}
        .navigationTitle("Место обучения")
        .buttonStyle(.borderedProminent)
    }
}

struct Register5: View {
    @State private var is_orphan: Bool = false
    @State private var is_disabled: Bool = false
    @State private var movements: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            Toggle("Имею статус ребёнка-сироты", isOn: $is_orphan)
            Toggle("Являюсь лицом с ограниченными возможностями здоровья", isOn: $is_disabled)
            Text("Членство в детско-юношеских организациях, движениях и пр.")
            TextField("Наименование (необязательно)", text: $movements)
        }.textFieldStyle(.roundedBorder).padding()
        NavigationLink {
            Register6()
        } label: {Text("Далее")}
        .navigationTitle("Дополнительно")
        .buttonStyle(.borderedProminent)
    }
}

struct Register6: View {
    @State private var why: String = ""
    @State private var what: String = ""
    @State private var info_source: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            Text("Чем вызвано мое решение принять участие в олимпиаде?")
            TextField("Необязательно", text: $why)
            Text("Почему меня интересует сфера финансов?")
            TextField("Необязательно", text: $what)
            Text("Источник информации об олимпиаде")
            TextField("Необязательно", text: $info_source)
        }.textFieldStyle(.roundedBorder).padding()
        NavigationLink {
            Register7()
        } label: {Text("Далее")}
        .navigationTitle("Об олимпиаде")
        .buttonStyle(.borderedProminent)
    }
}

struct Register7: View {
    @State private var parent_name: String = ""
    @State private var parent_email: String = ""
    @State private var parent_phone: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            Text("ФИО одного из родителей/опекуна")
            TextField("ФИО", text: $parent_name).textContentType(.middleName)
            Text("Email одного из родителей/опекуна")
            TextField("Email", text: $parent_email).textContentType(.emailAddress)
            Text("Телефон одного из родителей/опекуна")
            iPhoneNumberField(nil, text: $parent_phone).defaultRegion("RU")
                .flagHidden(false)
                .flagSelectable(true)
                .prefixHidden(false)
        }.textFieldStyle(.roundedBorder).padding()
        NavigationLink {
            Register8()
        } label: {Text("Далее")}
        .navigationTitle("Родители/опекуны")
        .buttonStyle(.borderedProminent)
    }
}

struct Register8: View {
    var body: some View {
        VStack(alignment: .leading) {
            
        }.textFieldStyle(.roundedBorder).padding()
        NavigationLink {
            MainView()
        } label: {Text("Далее")}
        .navigationTitle("Родители/опекуны")
        .buttonStyle(.borderedProminent)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
