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
    
    var context:NSManagedObjectContext?
    
    public var memoriaTVC:MemoriaTableViewController?
    
    var situacaoText:String?
    
    @IBOutlet weak var situacaoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if let memoria = memoria{
            situacaoTextField.text = memoria.situacao
        }
    }

    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if situacaoTextField.text != nil,
            situacaoTextField.text!.count > 0 {
            situacaoText = situacaoTextField.text!
        }
        if situacaoText != nil {
            if let _ = memoriaTVC {
                if let context = context {
                    if let novaSituacao = situacaoText {
                        memoria?.situacao = novaSituacao
                    }
                }
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            return true
        }
        return false
    }
}

