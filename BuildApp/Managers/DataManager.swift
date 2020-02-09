//
//  DataManager.swift
//  BuildApp
//
import Foundation
class DataManager {
    static func saveLogin(email: String, password: String) {
        guard let emailData = email.data(using: .utf8) else { return }
        guard let passwordData = password.data(using: .utf8) else { return }
        KeyChain.save(key: "userEmail", data: emailData)
        KeyChain.save(key: "userPassword", data: passwordData)
    }

    static func loadLogin() -> UserData? {
        guard let emailData = KeyChain.load(key: "userEmail"), let email = String(data: emailData, encoding: .utf8) else {
            return nil
        }

        guard let passwordData = KeyChain.load(key: "userPassword"), let password = String(data: passwordData, encoding: .utf8) else {
            return nil
        }

        return UserData(email: email, password: password)
    }

    static func formatCurrency(value: Double) -> String {
        if value.isNaN { return "-" }
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .decimal
        numberFormater.locale = Locale.init(identifier: "PT")
        numberFormater.maximumFractionDigits = 2
        numberFormater.minimumFractionDigits = 2
        
        return numberFormater.string(from: NSNumber(value: value)) ?? "-"
    }
    
    static func formatDate(dateString: String) -> String{
        let dateComponents = dateString.components(separatedBy: "-")
        if dateComponents.count < 3{
            return dateString
        }
      return "\(dateComponents[2])/\(dateComponents[1])/\(dateComponents[0])"
    }
}
