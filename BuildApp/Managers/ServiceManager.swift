//
//  ServiceManager.swift
//  BuildApp
//
import UIKit
class ServiceManager {
    static let baseUrl: String = "https://enigmatic-bayou-48219.herokuapp.com/api/v2"
    internal static func sendPost(serviceUrl: String, headers: [String: String] = [:], postData: [String: String], callback: @escaping (_ data: Data?) -> Void) {
        if let url = URL(string: "\(baseUrl)/\(serviceUrl)"){
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
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) -> UIImage {
        var imageData: Data? = nil
        
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            imageData = data
        }
        return UIImage(data: imageData!)!
    }
}
