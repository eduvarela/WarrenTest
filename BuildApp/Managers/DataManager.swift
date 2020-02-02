//
//  DataManager.swift
//  BuildApp
//
import Foundation
class DataManager{
    static func saveLogin(email: String, password: String){
        guard let emailData = email.data(using: .utf8) else{ return }
        guard let passwordData = password.data(using: .utf8) else{ return }
        KeyChain.save(key: "userEmail", data: emailData)
        KeyChain.save(key: "userPassword", data: passwordData)
    }
    
    static func loadLogin() -> UserData?{
        guard let emailData = KeyChain.load(key: "userEmail"), let email = String(data: emailData, encoding: .utf8) else{
            return nil
        }
        
        guard let passwordData = KeyChain.load(key: "userPassword"), let password = String(data: passwordData, encoding: .utf8) else{
               return nil
        }
        
        return UserData(email: email, password: password)
    }
}
