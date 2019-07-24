//
//  timelineMemoriasController.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 23/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class timelineMemoriasController: UITableViewController{
    
    public var memorias:[Memoria] = []
    
    var context:NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do{
            memorias = try context!.fetch(Memoria.fetchRequest())
        } catch {
            print("Falha na Timeline")
            return
        }
        tableView.reloadData()
    }
    
    //numero de linhas
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memorias.count
    }
    
    //carregar as células
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        celula.textLabel?.text = memorias[indexPath.row].situacao
//        cell.detailTextLabel?.text = "\(aulas[indexPath.row].cargaHoraria)" --> trocar para data
        return celula
    }
    
    //possibilitar edicao
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context?.delete(memorias[indexPath.row])
            memorias.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
    }
    
    @IBAction func addMemoria(_ sender: UIStoryboardSegue){
        if sender.source is TableViewController{
            if let senderAdd = sender.source as? TableViewController{
                if let memoria = senderAdd.novaMemoria{
                    memorias.append(memoria)
//                    noPartyImage.removeFromSuperview()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editarVC = segue.destination as? EditarMemoriaController {
            editarVC.memoriaVC = self
            if segue.identifier == "editarMemoria"{
                editarVC.memorias = memorias[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
    
}
