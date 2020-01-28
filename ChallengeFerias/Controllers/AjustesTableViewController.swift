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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verificarNotificacoes()
    }
    
    func verificarNotificacoes() {
        if UserDefaults.standard.string(forKey: "notificacoes") == "on" {
            switchButton.setOn(true, animated:true)
        } else {
            switchButton.setOn(false, animated:true)
        }
    }
    
    @IBOutlet weak var switchButton: UISwitch!

    @IBAction func switchButtonNotificationsClicked(_ sender: Any) {
        
        if switchButton.isOn {
            print("on")
            UserDefaults.standard.set("on", forKey: "notificacoes")
            
        } else {
            print("off")
            UserDefaults.standard.set("off", forKey: "notificacoes")
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["diario"])
        }
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
