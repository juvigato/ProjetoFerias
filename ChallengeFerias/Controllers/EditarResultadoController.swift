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
    
    /**
    *Carregar  todas características necessárias da tela*
     - Parameters: Nada
     - Returns: Nada
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultadoTextField.layer.borderWidth = 1
        resultadoTextField.layer.borderColor = UIColor.lightGray.cgColor
        resultadoTextField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        resultadoTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        resultadoTextField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
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
    
    /**
    *Quando a edição tiver terminado, o teclado irá sumir da tela*
     - Parameters: Nada
     - Returns: Nada
     */
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    /**
    *Definir como a textView irá parecer antes de ser editada*
     - Parameters:
      - textView: textView que está na tela
     - Returns: Nada
     */
    func textViewDidBeginEditing(_ textView: UITextView) {
        if resultadoTextField.text == "Escreva aqui..."{
            resultadoTextField.text = ""
            resultadoTextField.textColor = UIColor.black
        }
    }
    
    /**
    *Verificar se a textView está vazia após edição*
     - Parameters: Nada
     - Returns: Nada
     */
    func textViewDidEndEditing(_ textView: UITextView) {
        if resultadoTextField.text.isEmpty{
            resultadoTextField.text = "Escreva aqui..."
            resultadoTextField.textColor = UIColor.lightGray
        }
    }
    
    /**
    *Executar a segue recebida*
    - Parameters:
     - view: uma view do tipo UIView
    - Returns: Nada
    */
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
