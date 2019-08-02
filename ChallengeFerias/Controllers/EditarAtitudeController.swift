//
//  EditarAtitudeController.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 26/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditarAtitudeController:UIViewController, UITextViewDelegate{
    
    public var memoria:Memoria?
    
    var context:NSManagedObjectContext?
    
    public var memoriaTVC:MemoriaTableViewController?
    
    var atitudeText:String?
    
    @IBOutlet weak var atitudeTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        atitudeTextField.layer.borderWidth = 1
        atitudeTextField.layer.borderColor = UIColor.lightGray.cgColor
        atitudeTextField.delegate = self
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if let memoria = memoria{
            atitudeTextField.text = memoria.atitude
        }
        
        if memoria?.atitude != nil{
            if let memoria = memoria {
                atitudeTextField.text = memoria.atitude
            }
        } else{
            atitudeTextField.text = "Escreva aqui..."
            atitudeTextField.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if atitudeTextField.text == "Escreva aqui..."{
            atitudeTextField.text = ""
            atitudeTextField.textColor = UIColor.black
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if atitudeTextField.text.isEmpty{
            atitudeTextField.text = "Escreva aqui..."
            atitudeTextField.textColor = UIColor.lightGray
        }
    }

    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if atitudeTextField.text != nil, atitudeTextField.text!.count > 0{
            atitudeText = atitudeTextField.text
        }
        
        if atitudeText != nil {
            if let _ = memoriaTVC{
                if let context = context{
                    if let novaAtitude = atitudeText{
                        memoria?.atitude = novaAtitude
                    }
                }
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            return true
        }
        return false
    }
}
