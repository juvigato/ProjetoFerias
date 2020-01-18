//
//  NovaMemoriaViewController.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 22/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import UIKit
import CoreData

class NovaMemoriaViewController: UITableViewController{
    
    var context:NSManagedObjectContext?
    
    var novaMemoria:Memoria?
    
    var sentimentos:[String] = []
    
    @IBOutlet weak var tableViewLista: UITableView!
    
    @IBOutlet weak var imagemEmocao: UIImageView?
    
    @IBOutlet weak var imagemEmocaoBaixo: UIImageView?
    
    @IBOutlet weak var salvarBotaoNM: UIBarButtonItem!
    
    @IBOutlet weak var dataText: UILabel!
    
    var contadorBotoesSelecionados:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        sentimentos = []
        salvarBotaoNM.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataText.text = formatarData(date: Date())
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row != 0{
            if let cell = tableView.cellForRow(at: indexPath) {
                if cell.accessoryType == .none && contadorBotoesSelecionados < 2{
                    cell.accessoryType = .checkmark
                    contadorBotoesSelecionados = contadorBotoesSelecionados + 1
                    
                    if indexPath.row == 1{
                        sentimentos.append("Alegria")
                    } else if indexPath.row == 2{
                        sentimentos.append("tristeza")
                    } else if indexPath.row == 3{
                        sentimentos.append("raiva")
                    } else if indexPath.row == 4{
                        sentimentos.append("medo")
                    } else {
                        sentimentos.append("aversao")
                    }
                    mudarImagem()
                }
            }
        }
        
        if sentimentos.count > 0{
            salvarBotaoNM.isEnabled = true
        }
    }
    
    //mudar a data para string
    func formatarData(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dataAtual = formatter.string(from: date)
        return dataAtual
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            if cell.accessoryType == .checkmark{
                cell.accessoryType = .none
                contadorBotoesSelecionados = contadorBotoesSelecionados - 1
                
                if indexPath.row == 1{
                    if let index = sentimentos.firstIndex(of: "Alegria") {
                        sentimentos.remove(at: index)
                    }
                } else if indexPath.row == 2{
                    if let index = sentimentos.firstIndex(of: "tristeza") {
                        sentimentos.remove(at: index)
                    }
                } else if indexPath.row == 3{
                    if let index = sentimentos.firstIndex(of: "raiva") {
                        sentimentos.remove(at: index)
                    }
                } else if indexPath.row == 4{
                    if let index = sentimentos.firstIndex(of: "medo") {
                        sentimentos.remove(at: index)
                    }
                } else {
                    if let index = sentimentos.firstIndex(of: "aversao") {
                        sentimentos.remove(at: index)
                    }
                }
                mudarImagem()
            }
        }
        if sentimentos.count == 0{
            salvarBotaoNM.isEnabled = false
        }
 
    }
    
    func mudarImagem(){
        var sentimento1:String = ""
        var sentimento2:String = ""
        
        if let index = sentimentos.firstIndex(of: "Alegria"){
            if (sentimento1 == ""){
                sentimento1 = "Alegria"
                imagemEmocao?.image = #imageLiteral(resourceName: "alegria")
                if (sentimento1 == "Alegria" && sentimento2 == ""){
                    imagemEmocaoBaixo?.image = #imageLiteral(resourceName: "alegriaBaixo")
                }
            } else {
                sentimento2 = "Alegria"
                imagemEmocaoBaixo?.image = #imageLiteral(resourceName: "alegriaBaixo")
            }
        }
        if let index = sentimentos.firstIndex(of: "tristeza"){
            if (sentimento1 == ""){
                sentimento1 = "tristeza"
                imagemEmocao?.image = #imageLiteral(resourceName: "tristeza")
                if (sentimento1 == "tristeza" && sentimento2 == ""){
                    imagemEmocaoBaixo?.image = #imageLiteral(resourceName: "tristezaBaixo")
                }
            } else {
                sentimento2 = "tristeza"
                imagemEmocaoBaixo?.image = #imageLiteral(resourceName: "tristezaBaixo")
            }
        }
        if let index = sentimentos.firstIndex(of: "raiva"){
            if (sentimento1 == ""){
                sentimento1 = "raiva"
                imagemEmocao?.image = #imageLiteral(resourceName: "raiva")
                if (sentimento1 == "raiva" && sentimento2 == ""){
                    imagemEmocaoBaixo?.image = #imageLiteral(resourceName: "raivaBaixo")
                }
            } else {
                sentimento2 = "raiva"
                imagemEmocaoBaixo?.image = #imageLiteral(resourceName: "raivaBaixo")
            }
        }
        if let index = sentimentos.firstIndex(of: "medo"){
            if (sentimento1 == ""){
                sentimento1 = "medo"
                imagemEmocao?.image = #imageLiteral(resourceName: "medo")
                if (sentimento1 == "medo" && sentimento2 == ""){
                    imagemEmocaoBaixo?.image = #imageLiteral(resourceName: "medoBaixo")
                }
            } else {
                sentimento2 = "medo"
                imagemEmocaoBaixo?.image = #imageLiteral(resourceName: "medoBaixo")
            }
        }
        if let index = sentimentos.firstIndex(of: "aversao"){
            if (sentimento1 == ""){
                sentimento1 = "aversao"
                imagemEmocao?.image = #imageLiteral(resourceName: "aversao")
                if (sentimento1 == "aversao" && sentimento2 == ""){
                    imagemEmocaoBaixo?.image = #imageLiteral(resourceName: "aversaoBaixo")
                }
            } else {
                sentimento2 = "aversao"
                imagemEmocaoBaixo?.image = #imageLiteral(resourceName: "aversaoBaixo")
            }
        }
        if sentimento1 == "" && sentimento2 == ""{
            imagemEmocaoBaixo?.image = #imageLiteral(resourceName: "vazioBaixo")
            imagemEmocao?.image = #imageLiteral(resourceName: "vazioSolo")
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let context = context{
            novaMemoria = (NSEntityDescription.insertNewObject(forEntityName: "Memoria", into: context) as! Memoria)
            
            for x in sentimentos{
                let sentimento = (NSEntityDescription.insertNewObject(forEntityName: "Sentimento", into: context) as! Sentimento)
                sentimento.nome = x
                novaMemoria?.addToTem(sentimento)
            }
            
            novaMemoria?.data = Date() as NSDate
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            return true
        }
        return false
    }

    
    
}

