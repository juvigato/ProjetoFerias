//
//  ViewController.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 12/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import UIKit
import CoreData


class MemoriaTableViewController: UITableViewController {
    
    public var memoria:Memoria?
    
    public var timelineTVC: TimelineMemoriasController?
    
    var context: NSManagedObjectContext? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            performSegue(withIdentifier: "editarSituacao", sender: nil)
        } else if indexPath.row == 2{
            performSegue(withIdentifier: "editarPensamentos", sender: nil)
        } else if indexPath.row == 3{
            performSegue(withIdentifier: "editarAtitude", sender: nil)
        } else if indexPath.row == 4{
            performSegue(withIdentifier: "editarResultado", sender: nil)
        }
    }
    
    @IBAction func salvarBotao(_ sender: UIStoryboardSegue){
        if sender.source is EditarSituacaoController{
            if let senderAdd = sender.source as? EditarSituacaoController{
                if let situacao = senderAdd.situacaoText{
                    memoria?.situacao = situacao
                }
                
            }
        }
        
        if sender.source is EditarPensamentosController{
            if let senderAdd = sender.source as? EditarPensamentosController{
                if let pensamentos = senderAdd.pensamentosText{
                    memoria?.pensamentos = pensamentos
                }
            }
        }
        
        if sender.source is EditarAtitudeController{
            if let senderAdd = sender.source as? EditarAtitudeController{
                if let atitude = senderAdd.atitudeText{
                    memoria?.atitude = atitude
                }
            }
        }
        
        if sender.source is EditarResultadoController{
            if let senderAdd = sender.source as? EditarResultadoController{
                if let resultado = senderAdd.resultadoText{
                    memoria?.resultado = resultado
                }
            }
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let situacaoTVC = segue.destination as? EditarSituacaoController{
            if segue.identifier == "editarSituacao"{
                if let indexPath = tableView.indexPathForSelectedRow{
                    var memoriaTemp = memoria
                    situacaoTVC.memoria = memoriaTemp
                }
            }
        }
        
        if let pensamentosTVC = segue.destination as? EditarPensamentosController{
            if segue.identifier == "editarPensamentos"{
                if let indexPath = tableView.indexPathForSelectedRow{
                    var memoriaTemp = memoria
                    pensamentosTVC.memoria = memoriaTemp
                }
            }
        }
        
        if let atitudeTVC = segue.destination as? EditarAtitudeController{
            if segue.identifier == "editarAtitude"{
                if let indexPath = tableView.indexPathForSelectedRow{
                    var memoriaTemp = memoria
                    atitudeTVC.memoria = memoriaTemp
                }
            }
        }
        
        if let resultadoTVC = segue.destination as? EditarResultadoController{
            if segue.identifier == "editarResultado"{
                if let indexPath = tableView.indexPathForSelectedRow{
                    var memoriaTemp = memoria
                    resultadoTVC.memoria = memoriaTemp
                }
            }
        }

    }
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
////        if 
//    }
}

