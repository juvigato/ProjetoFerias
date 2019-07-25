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
    
    @IBOutlet weak var proximoBotao: UIBarButtonItem!
    
    @IBOutlet weak var imagemEmocao: UIImageView!
    
    
    @IBOutlet weak var alegriaBotao: UIButton!
    
//    var linhaSelecionada:Int = 0
//
    var contadorBotoesSelecionados:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.delegate = self
        self.tableView.dataSource = self
//        proximoBotao.isEnabled = false
        
        sentimentos = []
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    @IBAction func alegriaBotao(_ sender: Any){
        sentimentos.append("alegria")
//        var contadorAlegria:Int = 0
//        if contadorAlegria == 0{
//            alegriaBotao.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            sentimentos.append("alegria")
//            contadorAlegria = contadorAlegria + 1
//        } else {
//            alegriaBotao.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//            if let index = sentimentos.index(of: "alegria") {
//                sentimentos.remove(at: index)
//            }
//            contadorAlegria = contadorAlegria - 1
//        }
//
        
    }

    @IBAction func tristezaBotao(_ sender: Any){
        sentimentos.append("tristeza")
    }
    
    @IBAction func raivaBotao(_ sender: Any){
        sentimentos.append("raiva")
    }
    
    @IBAction func medoBotao(_ sender: Any){
        sentimentos.append("medo")
    }
    
    @IBAction func aversaoBotao(_ sender: Any){
        sentimentos.append("aversao")
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

