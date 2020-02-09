//
//  Application.swift
//  BuildApp
//
import Foundation
class Application{
    static let shared = Application()
    var login: LoginData? = nil
    var userData: UserData? = nil
    
    func loadApplicationData(){
        userData = DataManager.loadLogin()
    }
}
