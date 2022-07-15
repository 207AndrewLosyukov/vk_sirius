import SwiftUI

/// С помощью этой структуры мы получаем изображение и отрисовываем его.
struct ImageView: View {
    let urlString: String
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage).resizable().aspectRatio(contentMode: .fill).padding(.trailing).frame(width: 70, height: 70)
        } else {
            Image("").frame(width: 1, height: 1).onAppear {
                guard let url = URL(string: urlString) else {
                    return
                }
                let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                    self.data = data
                }
                task.resume()
            }
        }
    }
}

struct ContentView: View {
    @StateObject var data = GetData()

    var body: some View {
        NavigationView {
            List {
                ForEach(data.services, id: \.self) { service in
                    HStack {
                        ImageView(urlString: service.icon_url)
                        VStack() {
                            HStack() {
                                Text(service.name)
                                Spacer()
                            }
                            Spacer()
                            HStack() {
                                Text(service.description)
                                    .font(.footnote)
                                Spacer()
                            }
                        }
                        Link("", destination: URL(string: service.link)!)
                        Spacer()
                        Image(systemName: "chevron.forward")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .frame(width: 5.0, height: 10.0)
                            
                    }.listRowBackground(Color(UIColor.systemBackground))
                    
                }
            }.navigationTitle("Сервисы VK").navigationBarTitleDisplayMode(.inline)
        }.onAppear() {
            data.get()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
