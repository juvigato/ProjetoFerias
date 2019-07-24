//
//  ViewController.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 12/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import UIKit
import CoreData


class TableViewController: UITableViewController {
    
    public var memoria: Memoria?
    
    public var memoriaTVC: timelineMemoriasController?
    
    var context: NSManagedObjectContext?
    
    var novaMemoria:Memoria?
    
    @IBOutlet weak var botaoSalvarMemoria: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
//        botaoSalvarMemoria.isEnabled = false
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            performSegue(withIdentifier: "showSituacao", sender: nil)
        } else if indexPath.row == 2{
            performSegue(withIdentifier: "showPensamentos", sender: nil)
        } else if indexPath.row == 3{
            performSegue(withIdentifier: "showAtitude", sender: nil)
        } else if indexPath.row == 4{
            performSegue(withIdentifier: "showResultado", sender: nil)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let _ = memoriaTVC{
            if let context = context{
                novaMemoria = NSEntityDescription.insertNewObject(forEntityName: "Memoria", into: context) as! Memoria
                novaMemoria?.situacao = memoria!.situacao
                novaMemoria?.pensamentos = memoria!.pensamentos
                novaMemoria?.atitude = memoria!.atitude
                novaMemoria?.resultado = memoria!.resultado
                //arrumar o !
                
                context.delete(memoria!)
                    
                }
            
            memoriaTVC!.memorias.append(novaMemoria!)
            novaMemoria?.id = UUID().uuidString
            do {
                try context?.save()
            } catch{
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        return false
    }
    
}

