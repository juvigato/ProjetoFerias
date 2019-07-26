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

class EditarAtitudeController:UIViewController{
    
    public var memoria:Memoria?
    
    var context:NSManagedObjectContext?
    
    public var memoriaTVC:MemoriaTableViewController?
    
    var atitudeText:String?
    
    @IBOutlet weak var atitudeTextField: UITextField!
    //iboutlet
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if let memoria = memoria{
            atitudeTextField.text = memoria.atitude
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
