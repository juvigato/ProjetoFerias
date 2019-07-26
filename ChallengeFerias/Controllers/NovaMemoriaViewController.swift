//
//  NovaMemoriaViewController.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 22/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//


// add no CBL: fonte - https://www.youtube.com/watch?v=WDQkjOcrbQE

import UIKit
import CoreData

class NovaMemoriaViewController: UITableViewController{
    
//    var goingForwards:Bool = false
    
    var context:NSManagedObjectContext?
    
    var novaMemoria:Memoria?
    
    var sentimentos:[String] = []
    

    
    @IBOutlet weak var tableViewLista: UITableView!
    
//    @IBOutlet weak var proximoBotao: UIBarButtonItem!
    
    @IBOutlet weak var imagemEmocao: UIImageView?
    
    @IBOutlet weak var imagemEmocaoBaixo: UIImageView?
    
    @IBOutlet weak var alegriaBotao: UIButton!
    
    @IBOutlet weak var salvarBotaoNM: UIBarButtonItem!
    var contadorBotoesSelecionados:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.delegate = self
        self.tableView.dataSource = self
//        proximoBotao.isEnabled = false
        
        sentimentos = []
        salvarBotaoNM.isEnabled = false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row != 0{
            if let cell = tableView.cellForRow(at: indexPath) {
                if cell.accessoryType == .none && contadorBotoesSelecionados < 2{
                    cell.accessoryType = .checkmark
                    contadorBotoesSelecionados = contadorBotoesSelecionados + 1
                    
                    if indexPath.row == 1{
                        sentimentos.append("alegria")
                    } else if indexPath.row == 2{
                        sentimentos.append("tristeza")
                    } else if indexPath.row == 3{
                        sentimentos.append("raiva")
                    } else if indexPath.row == 4{
                        sentimentos.append("medo")
                    } else {
                        sentimentos.append("aversao")
                    }
//                    print(sentimentos[0])
                    mudarImagem()
                }
            }
        }
        
        if sentimentos.count > 0{
            salvarBotaoNM.isEnabled = true
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            if cell.accessoryType == .checkmark{
                cell.accessoryType = .none
                contadorBotoesSelecionados = contadorBotoesSelecionados - 1
                
                if indexPath.row == 1{
                    if let index = sentimentos.firstIndex(of: "alegria") {
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
        
        if let index = sentimentos.firstIndex(of: "alegria"){
            if (sentimento1 == ""){
                sentimento1 = "alegria"
                imagemEmocao?.image = #imageLiteral(resourceName: "alegria")
                if (sentimento1 == "alegria" && sentimento2 == ""){
                    imagemEmocaoBaixo?.image = #imageLiteral(resourceName: "alegriaBaixo")
                }
            } else {
                sentimento2 = "alegria"
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
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            return true
        }
        return false
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        if !goingForwards {
//            context?.delete(novaMemoria!)
//
//        }
//    }
    
    
}

