//
//  EditarSituacaoController.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 23/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditarSituacaoController:UIViewController{
    
    public var memoria:Memoria?
    
    public var memoriaVC:timelineMemoriasController?
    
    var context:NSManagedObjectContext?
    
    @IBOutlet weak var situacaoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if let memoria = memoria {
            situacaoTextField.text = memoria.situacao
            //            navigationItem.title = aula.nome
        } else {
            //            navigationItem.title = "Criar Aula"
        }
    }
    
    
    @IBAction func salvarSituacaoBotao(_ sender: Any) {
        var novaSituacao:String = "Situacao"
        
        if situacaoTextField.text != nil, situacaoTextField.text!.count > 0 {
            novaSituacao = situacaoTextField.text!
        }
        
        
        if let _ = memoria {
            memoria!.situacao = novaSituacao
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        } else {
            if let memoriaVC = memoriaVC {
                if let context = context {
                    var novaMemoria = NSEntityDescription.insertNewObject(forEntityName: "Memoria", into: context) as! Memoria
                    novaMemoria.situacao = novaSituacao
                    memoriaVC.memorias.append(novaMemoria)
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                }
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
}

