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

class EditarResultadoController:UIViewController, UITextViewDelegate{
    
    public var memoria:Memoria?
    
    var context:NSManagedObjectContext?
    
    public var memoriaTVC:MemoriaTableViewController?
    
    var resultadoText:String?
    
    @IBOutlet weak var resultadoTextField: UITextView!
    
    @IBOutlet weak var imagemResultado: UIImageView!
    
    var imagemBackground:UIImage = UIImage(named: "backgroundClaro.jpg") ?? UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultadoTextField.layer.borderWidth = 1
        resultadoTextField.layer.borderColor = UIColor.lightGray.cgColor
        resultadoTextField.delegate = self
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        self.view.backgroundColor = UIColor(patternImage: imagemBackground)
        
        if memoria?.resultado != nil{
            if let memoria = memoria {
                resultadoTextField.text = memoria.resultado
            }
        } else{
            resultadoTextField.text = "Escreva aqui..."
            resultadoTextField.textColor = UIColor.lightGray
        }
        
        if memoria?.titulo != nil {
            if let memoria = memoria {
                let nomeImg:String = memoria.titulo ?? "vazio"
                imagemResultado.image = UIImage(named: nomeImg)
            }
        } else {
            imagemResultado.image = UIImage(named: "vazio")
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if resultadoTextField.text == "Escreva aqui..."{
            resultadoTextField.text = ""
            resultadoTextField.textColor = UIColor.black
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if resultadoTextField.text.isEmpty{
            resultadoTextField.text = "Escreva aqui..."
            resultadoTextField.textColor = UIColor.lightGray
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
