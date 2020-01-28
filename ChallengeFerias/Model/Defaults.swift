//
//  Defaults.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 26/01/20.
//  Copyright © 2020 Juliana Vigato Pavan. All rights reserved.
//

import Foundation

struct Defaults {
    
    static let (temaKey) = ("tema")
    static let (notificacoesKey) = ("notificacoes")
    static let userSessionKey = "com.save.usersession"
    private static let userDefault = UserDefaults.standard
    
    struct UserDetails {
        let tema: String
        let notificacoes: String
        
        init(_ json: [String: String]) {
            self.tema = json[temaKey] ?? ""
            self.notificacoes = json[notificacoesKey] ?? "off"
        }
    }
    
    static func save(_ name: String){
        userDefault.set(name,
                        forKey: userSessionKey)
    }
    
    static func clearUserData(){
        userDefault.removeObject(forKey: userSessionKey)
    }
}
