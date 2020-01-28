//
//  Tema.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 26/01/20.
//  Copyright © 2020 Juliana Vigato Pavan. All rights reserved.
//

import Foundation
import UIKit

class TemaTableViewController:UITableViewController {
    
    let temas = ["Original", "Escala de cinza"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        
        celula.textLabel?.text = temas[indexPath.row]
        
        let tema = UserDefaults.standard.string(forKey: "tema")
        
        if temas[indexPath.row] == tema{
            celula.accessoryType = .checkmark
        }
        return celula
    }
    
    func desmarcarCelula(_ tableView: UITableView){
        for i in 0...temas.count{
            tableView.cellForRow(at: IndexPath(row: i, section: 0))?.accessoryType = .none
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        desmarcarCelula(tableView)
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        UserDefaults.standard.set(temas[indexPath.row], forKey: "tema")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
