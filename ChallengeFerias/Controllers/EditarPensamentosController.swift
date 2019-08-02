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

class EditarPensamentosController:UIViewController, UITextViewDelegate{
    
    public var memoria:Memoria?
    
    var context:NSManagedObjectContext?
    
    public var memoriaTVC:MemoriaTableViewController?
    
    var pensamentosText:String?
    
    @IBOutlet weak var pensamentosTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pensamentosTextField.layer.borderWidth = 1
        pensamentosTextField.layer.borderColor = UIColor.lightGray.cgColor
        pensamentosTextField.delegate = self
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if memoria?.pensamentos != nil{
            if let memoria = memoria {
                pensamentosTextField.text = memoria.pensamentos
            }
        } else{
            pensamentosTextField.text = "Escreva aqui..."
            pensamentosTextField.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if pensamentosTextField.text == "Escreva aqui..."{
            pensamentosTextField.text = ""
            pensamentosTextField.textColor = UIColor.black
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if pensamentosTextField.text.isEmpty{
            pensamentosTextField.text = "Escreva aqui..."
            pensamentosTextField.textColor = UIColor.lightGray
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
