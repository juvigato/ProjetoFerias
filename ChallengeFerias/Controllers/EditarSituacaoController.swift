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
    
    var imagemBackground:UIImage = UIImage(named: "backgroundClaro.jpg") ?? UIImage()
    
//    var imagemBackgroundCinza:UIImage = UIImage(named: "backgroundClaroCinza .jpg") ?? UIImage()
    
    @IBOutlet weak var situacaoTextField: UITextView!
    
    @IBOutlet weak var imagemSituacao: UIImageView!
    
    /**
    *Carregar  todas características necessárias da tela*
     - Parameters: Nada
     - Returns: Nada
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        situacaoTextField.layer.borderWidth = 1
        situacaoTextField.layer.borderColor = UIColor.lightGray.cgColor
        situacaoTextField.delegate = self
        situacaoTextField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        situacaoTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.view.backgroundColor = UIColor(patternImage: imagemBackground)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if memoria?.situacao != nil{
            if let memoria = memoria {
                situacaoTextField.text = memoria.situacao
            }
        } else{
            situacaoTextField.text = "Escreva aqui..."
            situacaoTextField.textColor = UIColor.lightGray
        }
        
        if memoria?.titulo != nil {
            if let memoria = memoria {
                let nomeImg:String = memoria.titulo ?? "vazio"
                imagemSituacao.image = UIImage(named: nomeImg)
            }
        } else {
            imagemSituacao.image = UIImage(named: "vazio")
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
        if situacaoTextField.text == "Escreva aqui..."{
            situacaoTextField.text = ""
            situacaoTextField.textColor = UIColor.black
        }
    }

    /**
    *Verificar se a textView está vazia após edição*
     - Parameters: Nada
     - Returns: Nada
     */
    func textViewDidEndEditing(_ textView: UITextView) {
        if situacaoTextField.text.isEmpty{
            situacaoTextField.text = "Escreva aqui..."
            situacaoTextField.textColor = UIColor.lightGray
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
