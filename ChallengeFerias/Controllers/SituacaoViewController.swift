//
//  SituacaoViewController.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 19/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SituacaoViewController: UIViewController, UITextFieldDelegate{
    
    public var memoria: Memoria?
    
    @IBOutlet weak var situacaoInput: UITextField!
    
    var context: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if let memoria = memoria{
            situacaoInput.text = memoria.situacao
        }
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        self.view.addGestureRecognizer(tap)
        
//        situacaoInput.delegate = self
//        situacaoInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @IBAction func botaoSalvar(_ sender: Any) {
        var novaSituacao:String = ""
        
        if situacaoInput.text != nil, situacaoInput.text!.count > 0 {
            novaSituacao = situacaoInput.text!
        }
    }
    
    
}
