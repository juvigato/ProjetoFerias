//
//  NovaMemoriaViewController.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 22/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//


// add no CBL: fonte - https://www.youtube.com/watch?v=WDQkjOcrbQE

import UIKit

class NovaMemoriaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewLista: UITableView!
    
    var lista:[String] = Array()
    
    var linhaSelecionada:Int = 0
    
    var contadorBotoesSelecionados:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lista.append("Alegria")
        lista.append("Tristeza")
        lista.append("Raiva")
        lista.append("Medo")
        lista.append("Aversão")
        tableViewLista.register(UINib.init(nibName: "CheckMarkCell", bundle: nil), forCellReuseIdentifier: "CheckListIdentifier")
        tableViewLista.dataSource = self
        tableViewLista.delegate = self
        tableViewLista.rowHeight = 43.5
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListIdentifier") as! CheckMarkCell
        cell.lblTitle.text = lista[indexPath.row]
        cell.selectionStyle = .none
        cell.btnCheckMark.addTarget(self, action: #selector(checkMarkButtonClicked(sender:)), for: .touchUpInside)
        return cell
    }
      
    
    @objc func checkMarkButtonClicked ( sender: UIButton) {
//        print("button presed")
        
        if sender.isSelected {
            //botao selecionaco
            //botao está ficando nao selecionado
            contadorBotoesSelecionados = contadorBotoesSelecionados - 1
            sender.isSelected = false
            sender.setImage(#imageLiteral(resourceName: "UnChecked"), for: .normal)
        } else {
            //botao nao selecionado
            if contadorBotoesSelecionados < 2{
                //botao ficando selecionado
                contadorBotoesSelecionados = contadorBotoesSelecionados + 1
                sender.isSelected = true
                sender.setImage(#imageLiteral(resourceName: "Checked"), for: .normal)
            }
        }
//        print(contadorBotoesSelecionados)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
}

