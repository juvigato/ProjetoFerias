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
    
    @IBOutlet weak var imagemAtitude: UIImageView!
    
    var imagemBackground:UIImage = UIImage(named: "backgroundClaro.jpg") ?? UIImage()
    
    var imagemBackgroundCinza:UIImage = UIImage(named: "backgroundClaroCinza.jpg") ?? UIImage()
    
    /**
    *Carregar  todas características necessárias da tela*
     - Parameters: Nada
     - Returns: Nada
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        atitudeTextField.layer.borderWidth = 1
        atitudeTextField.layer.borderColor = UIColor.lightGray.cgColor
        atitudeTextField.delegate = self
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        self.view.backgroundColor = UIColor(patternImage: imagemBackground)
        
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
        
        if memoria?.titulo != nil {
            if let memoria = memoria {
                let nomeImg:String = memoria.titulo ?? "vazio"
                imagemAtitude.image = UIImage(named: nomeImg)
            }
        } else {
            imagemAtitude.image = UIImage(named: "vazio")
        }
    }
    
    /**
    *Definir como a textView irá parecer antes de ser editada*
     - Parameters:
      - textView: textView que está na tela
     - Returns: Nada
     */
    func textViewDidBeginEditing(_ textView: UITextView) {
        if atitudeTextField.text == "Escreva aqui..."{
            atitudeTextField.text = ""
            atitudeTextField.textColor = UIColor.black
        }
    }
    
    /**
    *Verificar se a textView está vazia após edição*
     - Parameters: Nada
     - Returns: Nada
     */
    func textViewDidEndEditing(_ textView: UITextView) {
        if atitudeTextField.text.isEmpty{
            atitudeTextField.text = "Escreva aqui..."
            atitudeTextField.textColor = UIColor.lightGray
        }
    }

    /**
    *Executar a segue recebida*
    - Parameters:
     - identifier: string que representa o id da tela que será apresentada
     - sender: gatilho do storyboard
    - Returns: Valor booleano
    */
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
