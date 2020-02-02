//
//  ServiceManager.swift
//  BuildApp
//
import Foundation
class ServiceManager {
    static let baseUrl: String = "https://enigmatic-bayou-48219.herokuapp.com/api/v2"
    static func sendPost(serviceUrl: String, postData: [String: String], callback: @escaping (_ data: Data?) -> Void) {
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
}
