//
//  AjustesTableViewController.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 27/01/20.
//  Copyright © 2020 Juliana Vigato Pavan. All rights reserved.
//

import Foundation
import UIKit

class AjustesTableViewController:UITableViewController{
    
    var imagemBackground:UIImage = UIImage(named: "backgroundClaro.jpg") ?? UIImage()
    
    @IBOutlet weak var switchButton: UISwitch!

    /**
    *Quando clicado, detecta se o botão switch está ativado ou não*
    - Parameters:
      - sender: botão clicado
    - Returns: Nada
    */
    @IBAction func switchButtonNotificationsClicked(_ sender: Any) {
        if switchButton.isOn {
            print("on")
            UserDefaults.standard.set("on", forKey: "notificacoes")
            
        } else {
            print("off")
            UserDefaults.standard.set("off", forKey: "notificacoes")
//            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["5seconds"])
        }
    }
    
    /**
    *Carregar  todas características necessárias da tela*
    - Parameters: Nada
    - Returns: Nada
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: imagemBackground)
//        verificarNotificacoes()
    }
    
    /**
    *Verificar se as notifições estão ativadas ou desativadas*
    - Parameters: Nada
    - Returns: Nada
    */
    func verificarNotificacoes() {
        if UserDefaults.standard.string(forKey: "notificacoes") == "on" {
            switchButton.setOn(true, animated:true)
        } else {
            switchButton.setOn(false, animated:true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
