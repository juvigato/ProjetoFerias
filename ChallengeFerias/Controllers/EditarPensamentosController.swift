//
//  EditarPensamentosController.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 25/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditarPensamentosController:UIViewController{
    
    public var memoria:Memoria?
    
    var context:NSManagedObjectContext?
    
    public var memoriaTVC:MemoriaTableViewController?
    
    var pensamentosText:String?
    
    @IBOutlet weak var pensamentosTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if let memoria = memoria{
            pensamentosTextField.text = memoria.pensamentos
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if pensamentosTextField.text != nil, pensamentosTextField.text!.count > 0{
            pensamentosText = pensamentosTextField.text
        }
        if pensamentosText != nil {
            if let _ = memoriaTVC{
                if let context = context{
                    if let novoPensamento = pensamentosText{
                        memoria?.pensamentos = novoPensamento
                    }
                }
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            return true
        }
        return false
    }
    
}
