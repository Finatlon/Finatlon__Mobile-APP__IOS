//
//  ContentView.swift
//  Finatlon
//
//  Created by Дмитрий Канский on 11.12.2022.
//

import SwiftUI
import WebKit
import iPhoneNumberField
import PhotosUI

struct WebView: UIViewRepresentable {
 
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
}

struct ContentView: View {
    @State var CurrentScreen = 0
    var body: some View {
        switch CurrentScreen {
        case 0:
            LoginView(CurrentScreen: $CurrentScreen)
        case 1:
            MainView(CurrentScreen: $CurrentScreen)
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
    @Binding var CurrentScreen: Int
    var body: some View {
        TabView {
            NewsView()
                .tabItem {
                    Label("Новости", systemImage: "newspaper")
                }
            TaskView()
                .tabItem {
                    Label("Олимпиада", systemImage: "checklist")
                }
            AccountView(CurrentScreen: self.$CurrentScreen)
                .tabItem {
                    Label("Аккаунт", systemImage: "person.crop.circle")
                }
        }
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
                ScrollView {
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
                                Register2(CurrentScreen: self.$CurrentScreen)
                            } label: {
                                Text("Далее")
                            }.navigationTitle("Личные данные")
                                .padding(.leading).buttonStyle(.borderedProminent)
                        }
                    }
                }
            }
    }
}

struct Register2: View {
    @Binding var CurrentScreen: Int
    @State private var coutry: String = ""
    @State private var fed_district: String = ""
    @State private var region: String = ""
    @State private var postal_code: String = ""
    var body: some View {
        ScrollView {
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
                        Text("Не Москва").tag("Не Москва")
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
                Register3(CurrentScreen: self.$CurrentScreen)
            } label: {Text("Далее")}
                .navigationTitle("Место проживания")
                .buttonStyle(.borderedProminent)
        }
    }
}

struct Register3: View {
    @Binding var CurrentScreen: Int
    @State private var town_type: String = ""
    @State private var town: String = ""
    @State private var str: String = ""
    @State private var bld: String = ""
    @State private var apt: String = ""
    @State private var is_village: Bool = false
    var body: some View {
        ScrollView {
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
                Register4(CurrentScreen: self.$CurrentScreen)
            } label: {Text("Далее")}
                .navigationTitle("Место проживания")
                .buttonStyle(.borderedProminent)
        }
    }
}

struct Register4: View {
    @Binding var CurrentScreen: Int
    @State private var cls_year: Int = 0
    @State private var school: String = ""
    @State private var sch_phone: String = ""
    @State private var sch_postal_code: String = ""
    @State private var sch_country: String = ""
    @State private var sch_str: String = ""
    @State private var sch_bld: String = ""
    @State private var sch_email: String = ""
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack() {
                    Text("Класс обучения")
                    Spacer()
                    Picker("", selection: $cls_year) {
                        Text("6").tag(6)
                        Text("7").tag(7)
                        Text("8").tag(8)
                        Text("9").tag(9)
                        Text("10").tag(10)
                        Text("11").tag(11)
                        Text("1 курс").tag(1)
                        Text("2 курс").tag(2)
                        Text("3 курс").tag(3)
                        Text("4 курс").tag(4)
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
                Register5(CurrentScreen: self.$CurrentScreen)
            } label: {Text("Далее")}
                .navigationTitle("Место обучения")
                .buttonStyle(.borderedProminent)
        }
    }
}

struct Register5: View {
    @Binding var CurrentScreen: Int
    @State private var is_orphan: Bool = false
    @State private var is_disabled: Bool = false
    @State private var movements: String = ""
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Toggle("Имею статус ребёнка-сироты", isOn: $is_orphan)
                Toggle("Являюсь лицом с ограниченными возможностями здоровья", isOn: $is_disabled)
                Text("Членство в детско-юношеских организациях, движениях и пр.")
                TextField("Наименование (необязательно)", text: $movements)
            }.textFieldStyle(.roundedBorder).padding()
            NavigationLink {
                Register6(CurrentScreen: self.$CurrentScreen)
            } label: {Text("Далее")}
                .navigationTitle("Дополнительно")
                .buttonStyle(.borderedProminent)
        }
    }
}

struct Register6: View {
    @Binding var CurrentScreen: Int
    @State private var why: String = ""
    @State private var what: String = ""
    @State private var info_source: String = ""
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Чем вызвано мое решение принять участие в олимпиаде?")
                TextField("Необязательно", text: $why)
                Text("Почему меня интересует сфера финансов?")
                TextField("Необязательно", text: $what)
                Text("Источник информации об олимпиаде")
                TextField("Необязательно", text: $info_source)
            }.textFieldStyle(.roundedBorder).padding()
            NavigationLink {
                Register7(CurrentScreen: self.$CurrentScreen)
            } label: {Text("Далее")}
                .navigationTitle("Об олимпиаде")
                .buttonStyle(.borderedProminent)
        }
    }
}

struct Register7: View {
    @Binding var CurrentScreen: Int
    @State private var parent_name: String = ""
    @State private var parent_email: String = ""
    @State private var parent_phone: String = ""
    var body: some View {
        ScrollView {
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
                Register8(CurrentScreen: self.$CurrentScreen)
            } label: {Text("Далее")}
                .navigationTitle("Родители/опекуны")
                .buttonStyle(.borderedProminent)
        }
    }
}

struct Register8: View {
    @Binding var CurrentScreen: Int
    @State private var teacher_name: String = ""
    @State private var teacher_email: String = ""
    @State private var teacher_phone: String = ""
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("ФИО учителя")
                TextField("ФИО", text: $teacher_name).textContentType(.middleName)
                Text("Email учителя")
                TextField("Email", text: $teacher_email).textContentType(.emailAddress)
                Text("Телефон учителя")
                iPhoneNumberField(nil, text: $teacher_phone).defaultRegion("RU")
                    .flagHidden(false)
                    .flagSelectable(true)
                    .prefixHidden(false)
            }.textFieldStyle(.roundedBorder).padding()
            NavigationLink {
                Register9(CurrentScreen: self.$CurrentScreen)
            } label: {Text("Далее")}
                .navigationTitle("Учитель")
                .buttonStyle(.borderedProminent)
        }
    }
}

struct Register9: View {
    @Binding var CurrentScreen: Int
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var password_repeat: String = ""
    @State private var role: String = ""
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Email")
                TextField("Email", text: $username).textContentType(.emailAddress)
                HStack() {
                    Text("Роль")
                    Spacer()
                    Picker("", selection: $role) {
                        Text("Школьник").tag("Школьник")
                        Text("Студент СПО").tag("Студент СПО")
                        Text("Студент ВУЗа").tag("Студент ВУЗа")
                        Text("Другое").tag("Другое")
                    }
                }
                Text("Пароль (не менее 6 символов)")
                SecureField(text: $password, prompt: Text("Пароль")) {Text("пароль")}.textContentType(.password)
                Text("Повторите пароль")
                SecureField(text: $password_repeat, prompt: Text("Пароль")) {Text("пароль")}.textContentType(.password)
            }.textFieldStyle(.roundedBorder).padding()
            NavigationLink {
                RegisterSuccess(CurrentScreen: self.$CurrentScreen)
            } label: {Text("Далее")}
                .navigationTitle("Данные для входа")
                .buttonStyle(.borderedProminent)
        }
    }
}

struct RegisterSuccess: View {
    @Binding var CurrentScreen: Int
    var body: some View {
        VStack(spacing: 25.0) {
            Image(systemName: "person.fill.checkmark")
            Text("Вы зарегистрированы!")
            Button("Войти", action: {self.CurrentScreen = 0}).buttonStyle(.borderedProminent)
        }
    }
}

struct NewsView: View {
    var body: some View {
        WebView(url: URL(string: "https://www.fin-olimp.ru/category/novosti-sobytiya/")!) //Для теста
    }
}

struct TaskView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Здесь будут задания олимпиады")
        }
    }
}

struct AccountView: View {
    @Binding var CurrentScreen: Int
    @State private var selection: String?
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image(systemName: "person")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50.0, height: 50.0)
                    .background(.gray)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(verbatim: "Имя Фамилия")
                    Text(verbatim: "example@example.com")
                }
            }
            NavigationView {
                List(selection: $selection) {
                    NavigationLink {
                        PersonalInfo()
                    } label: {
                        Text("Личные данные")
                    }
                    NavigationLink {
                        OlympResults()
                    } label: {
                        Text("Результаты олимпиады")
                    }
                    NavigationLink {
                        ResultsAppeal()
                    } label: {
                    Text("Апелляция результатов")
                    }
                    NavigationLink {
                        Contacts()
                    } label: {
                        Text("Контактная информация")
                    }
                    NavigationLink {
                        Suggestions()
                    } label: {
                        Text("Отзывы и предложения")
                    }
                    NavigationLink {
                        HelpView()
                    } label: {
                        Text("Помощь")
                    }
                    Text("Выйти из аккаунта")
                        .foregroundColor(Color.red)
                        .onTapGesture {
                            CurrentScreen = 0
                        }
                }
            }
        }
    }
}

struct PersonalInfo: View {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var lastname: String = ""
    @State private var givenname: String = ""
    @State private var middlename: String = ""
    @State private var school: String = ""
    @State private var phone: String = ""
    @State private var teacher_phone: String = ""
    @State private var username: String = ""
    @State private var region: String = ""
    @State private var town: String = ""
    @State private var cls_year: Int = 0
    var body: some View {
        ScrollView {
            Image(systemName: "person")
                .aspectRatio(contentMode: .fit)
                .frame(width: 100.0, height: 100.0)
                .background(.gray)
                .clipShape(Circle())
                .onTapGesture {
                    showingImagePicker = true
                    //ImagePicker(image: $inputImage)
                }
            VStack(alignment: .leading) {
                Text("Фамилия")
                Group {
                    TextField("Фамилия", text: $lastname)
                        .textContentType(.familyName)
                    Text("Имя")
                    TextField("Имя", text: $givenname).textContentType(.givenName)
                    Text("Отчество")
                    TextField("Отчество", text: $middlename).textContentType(.middleName)
                    Text("Телефон")
                    iPhoneNumberField(nil, text: $phone).defaultRegion("RU")
                        .flagHidden(false)
                        .flagSelectable(true)
                        .prefixHidden(false)
                    Text("Email")
                    TextField("Email", text: $username).textContentType(.emailAddress)
                    Text("Школа")
                }
                Group {
                    TextField("Школа", text: $school)
                    HStack() {
                        Text("Класс обучения")
                        Spacer()
                        Picker("", selection: $cls_year) {
                            Text("6").tag(6)
                            Text("7").tag(7)
                            Text("8").tag(8)
                            Text("9").tag(9)
                            Text("10").tag(10)
                            Text("11").tag(11)
                            Text("1 курс").tag(1)
                            Text("2 курс").tag(2)
                            Text("3 курс").tag(3)
                            Text("4 курс").tag(4)
                        }
                    }
                    HStack() {
                        Text("Регион").padding(.trailing)
                        Spacer()
                        Picker("", selection: $region) {
                            Text("Москва").tag("Москва")
                            Text("Не Москва").tag("Не Москва")
                            Text("Челябинская область").tag("Челябинская область")
                            Text("???").tag("???")
                            Text("Ханты-Мансийский Автономный Округ — Югра").tag("Ханты-Мансийский Автономный Округ — Югра")
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
                    Text("Телефон учителя")
                    iPhoneNumberField(nil, text: $teacher_phone).defaultRegion("RU")
                        .flagHidden(false)
                        .flagSelectable(true)
                        .prefixHidden(false)
                }
            }.textFieldStyle(.roundedBorder).padding()
        }
    }
}

struct OlympResults: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("После проведения олимпиады здесь будут результаты")
                .multilineTextAlignment(.center)
        }
    }
}

struct ResultsAppeal: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("После проведения олимпиады здесь можно аппелировать результаты")
                .multilineTextAlignment(.center)
        }
    }
}

struct Contacts: View {
    var body: some View {
        VStack(alignment: .center) {
            Link(destination: URL(string: "tel:+74953690402,5")!) {
                Text("📞 +74953690402 доб. 5")
                    .accentColor(Color.white)
                    .padding()
                    .background(.green)
                    .font(.headline)
            }
            Link(destination: URL(string: "mailto:olimpiada@ifru.ru")!) {
                Text("✉️ olimpiada@ifru.ru")
                    .accentColor(Color.white)
                    .padding()
                    .background(.blue)
                    .font(.headline)
            }
        }
    }
}

struct Suggestions: View {
    @State private var selection: String?
    @State private var review: String = ""
    var body: some View {
        VStack(alignment: .center) {
            Picker("", selection: $selection) {
                Text("Отзыв об олимпиаде").tag("Отзыв об олимпиаде")
                Text("Отзыв о приложении").tag("Отзыв о приложении")
                Text("Другое").tag("Другое")
            }
            TextEditor(text: $review).border(Color.gray, width: 5)
            Button("Отправить", action: {}).buttonStyle(.borderedProminent)
        }
    }
}

struct HelpView: View {
    var body: some View {
        WebView(url: URL(string: "https://ya.ru/")!) //Для теста
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
