//
//  Application.swift
//  BuildApp
//
import Foundation
class Application{
    static let shared = Application()
    var login: LoginData? = nil
    var userData: UserData? = nil
    var portfolios: PortfoliosData? = nil
    
    func loadApplicationData(){
        userData = DataManager.loadLogin()
    }
}
