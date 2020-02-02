//
//  ServiceManager.swift
//  BuildApp
//
import Foundation
class ServiceManager {
    static let baseUrl: String = "https://enigmatic-bayou-48219.herokuapp.com/api/v2"
    internal static func sendPost(serviceUrl: String, postData: [String: String], callback: @escaping (_ data: Data?) -> Void) {
        if let url = URL(string: "\(baseUrl)/\(serviceUrl)"){
            var request = URLRequest(url: url)
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            request.httpMethod = "POST"
            request.httpBody = try! JSONEncoder().encode(postData)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                callback(data)
            }
            task.resume()
        }
    }
    
    static func login(email: String, password: String){
        let userData = ["email": email, "password": password]
        sendPost(serviceUrl: "account/login", postData: userData) { (data) in
            if let loginData = data{
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
}
