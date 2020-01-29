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
    
    let temas = ["Original", "Escala de cinza", "Cores pastéis"]
    
    var imagemBackground:UIImage = UIImage(named: "backgroundClaro.jpg") ?? UIImage()
    
    /**
    *Carregar  todas características necessárias da tela*
     - Parameters: Nada
     - Returns: Nada
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: imagemBackground)

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    /**
    *Checar número de linhas em uma tableview*
     - Parameters:
      - tableView: uma tableView que irá aparecer na tela do tipo UITableView
      - numberOfRowsInSection: número de linhas em uma seção do tipo Inteiro
     - Returns: um número Inteiro
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temas.count
    }
    
    /**
    *Carregar células da tableView e seus respectivos itens*
     - Parameters:
      - tableView: tableView que aparecerá na tela
      - indexPath: index da célula da tableView
     - Returns: célula da tableView recebida
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        
        celula.textLabel?.text = temas[indexPath.row]
        celula.textLabel?.textColor = UIColor.black
        
        let tema = UserDefaults.standard.string(forKey: "tema")
        
        if temas[indexPath.row] == tema{
            celula.accessoryType = .checkmark
        }
        return celula
    }
    
    /**
    *Tira o checkmark da célula que foi desmarcada*
     - Parameters:
      - tableView: tableView que aparecerá na tela
     - Returns: Nada
     */
    func desmarcarCelula(_ tableView: UITableView){
        for i in 0...temas.count{
            tableView.cellForRow(at: IndexPath(row: i, section: 0))?.accessoryType = .none
        }
    }

    /**
    *Detecta qual linha foi selecionada*
     - Parameters:
      - tableView: tableView que aparecerá na tela
      - indexPath: index da célula da tableView
     - Returns: Nada
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        desmarcarCelula(tableView)
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        UserDefaults.standard.set(temas[indexPath.row], forKey: "tema")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
