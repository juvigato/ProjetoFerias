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

class EditarSituacaoController:UIViewController, UITextViewDelegate{
    
    public var memoria:Memoria?
    
    var context:NSManagedObjectContext?
    
    public var memoriaTVC:MemoriaTableViewController?
    
    var situacaoText:String?
    
    @IBOutlet weak var situacaoTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        situacaoTextField.layer.borderWidth = 1
        situacaoTextField.layer.borderColor = UIColor.lightGray.cgColor
        situacaoTextField.delegate = self

        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        
        if memoria?.situacao != nil{
            if let memoria = memoria {
                situacaoTextField.text = memoria.situacao
            }
        } else{
            situacaoTextField.text = "Escreva aqui..."
            situacaoTextField.textColor = UIColor.lightGray
        }
        
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if situacaoTextField.text == "Escreva aqui..."{
            situacaoTextField.text = ""
            situacaoTextField.textColor = UIColor.black
        }
    }


    func textViewDidEndEditing(_ textView: UITextView) {
        if situacaoTextField.text.isEmpty{
            situacaoTextField.text = "Escreva aqui..."
            situacaoTextField.textColor = UIColor.lightGray
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
