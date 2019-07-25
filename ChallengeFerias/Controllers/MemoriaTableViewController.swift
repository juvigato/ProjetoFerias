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
            performSegue(withIdentifier: "showPensamentos", sender: nil)
        } else if indexPath.row == 3{
            performSegue(withIdentifier: "showAtitude", sender: nil)
        } else if indexPath.row == 4{
            performSegue(withIdentifier: "showResultado", sender: nil)
        }
    }
    
    @IBAction func salvarSituacao(_ sender: UIStoryboardSegue){
        if sender.source is EditarSituacaoController{
            if let senderAdd = sender.source as? EditarSituacaoController{
            
            }
        }
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

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if let _ = timelineTVC{
//            if let context = context{
//                novaMemoria = NSEntityDescription.insertNewObject(forEntityName: "Memoria", into: context) as! Memoria
//                novaMemoria?.situacao = memoria!.situacao
//                novaMemoria?.pensamentos = memoria!.pensamentos
//                novaMemoria?.atitude = memoria!.atitude
//                novaMemoria?.resultado = memoria!.resultado
//                //arrumar o !
//
//                context.delete(memoria!)
//
//                }
//
//            timelineTVC!.memorias.append(novaMemoria!)
//            novaMemoria?.id = UUID().uuidString
//            do {
//                try context?.save()
//            } catch{
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//        return false
//    }
//
}

