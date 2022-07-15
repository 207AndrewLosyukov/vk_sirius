import Foundation

/// Класс отвечает за получение данных из json.
class GetData : ObservableObject {
    /// Функция получает данные из json.
    func get() {
        guard let url = URL(string: "https://publicstorage.hb.bizmrg.com/sirius/result.json") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let decode = try JSONDecoder().decode(JSONDecode.self, from: data)
                DispatchQueue.main.async {
                    self?.services = decode.body.services
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    /// В данном списке мы храним все полученные сервисы.`
    @Published var services: [Service] = []
}

