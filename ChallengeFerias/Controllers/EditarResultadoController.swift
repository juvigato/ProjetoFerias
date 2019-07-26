//
//  EditarResultadoController.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 26/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditarResultadoController:UIViewController{
    
    public var memoria:Memoria?
    
    var context:NSManagedObjectContext?
    
    public var memoriaTVC:MemoriaTableViewController?
    
    var resultadoText:String?
    
    @IBOutlet weak var resultadoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if let memoria = memoria{
            resultadoTextField.text = memoria.resultado
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if resultadoTextField.text != nil, resultadoTextField.text!.count > 0{
            resultadoText = resultadoTextField.text
        }
        
        if resultadoText != nil{
            if let _ = memoriaTVC{
                if let context = context{
                    if let novoResultado = resultadoText{
                        memoria?.resultado = novoResultado
                    }
                }
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            return true
        }
        return false
    }
}
