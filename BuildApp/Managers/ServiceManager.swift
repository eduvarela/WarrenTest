//
//  ServiceManager.swift
//  BuildApp
//
import UIKit
class ServiceManager {
    static let baseUrl: String = "https://enigmatic-bayou-48219.herokuapp.com/api/v2"
    internal static func sendPost(serviceUrl: String, headers: [String: String] = [:], postData: [String: String], callback: @escaping (_ data: Data?) -> Void) {
        if let url = URL(string: "\(baseUrl)/\(serviceUrl)") {
            var request = URLRequest(url: url)
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")

            headers.forEach { (key, value) in
                request.setValue(value, forHTTPHeaderField: key)
            }

            request.httpMethod = "POST"
            request.httpBody = try! JSONEncoder().encode(postData)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                callback(data)
            }
            task.resume()
        }
    }

    internal static func sendGet(serviceUrl: String, headers: [String: String] = [:], callback: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        if let url = URL(string: "\(baseUrl)/\(serviceUrl)") {

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            headers.forEach { (key, value) in
                request.setValue(value, forHTTPHeaderField: key)
            }

            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
                callback(data, error)
            }
            task.resume()
        }
    }

    static func login(email: String, password: String) {
        let userData = ["email": email, "password": password]
        sendPost(serviceUrl: "account/login", postData: userData) { (data) in
            if let loginData = data {
                let decoder = JSONDecoder()
                do {
                    let login = try decoder.decode(LoginData.self, from: loginData)
                    Application.shared.login = login
                    DataManager.saveLogin(email: email, password: password)
                    NotificationCenter.default.post(name: .didReceivedLoginResult, object: nil)
                } catch {
                    NotificationCenter.default.post(name: .didReceivedLoginResult, object: nil)
                    print(error.localizedDescription)
                }
            }
        }
    }

    static func portfolios() {
        if let accessToken = Application.shared.login?.accessToken {
            sendGet(serviceUrl: "portfolios/mine", headers: ["access-token": accessToken]) { (data, error) in
                if error != nil { return }
                if let portifoliosData = data {

                    if let jsonstring = String(data: portifoliosData, encoding: String.Encoding.utf8) {
                        print(jsonstring)
                    }

                    let decoder = JSONDecoder()
                    do {
                        let portfolios = try decoder.decode(PortfoliosData.self, from: portifoliosData)
                        Application.shared.portfolios = portfolios
                        NotificationCenter.default.post(name: .didReceivedPortfolios, object: nil)
                    } catch {
                        NotificationCenter.default.post(name: .didReceivedPortfolios, object: nil)
                    }
                }
            }
        }
    }

 static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    static func downloadImage(from urlString: String) -> UIImage {
        let urlImage = URL(string: urlString)
        if let imageData = try? Data(contentsOf: urlImage!){
            let coverImage = UIImage(data: imageData)
            return coverImage!
        }
        return UIImage()
    }

}
