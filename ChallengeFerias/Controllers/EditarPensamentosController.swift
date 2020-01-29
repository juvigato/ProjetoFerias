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
    
    @IBOutlet weak var imagemPensamentos: UIImageView!
    
    var imagemBackground:UIImage = UIImage(named: "backgroundClaro.jpg") ?? UIImage()
    
    /**
    *Carregar  todas características necessárias da tela*
     - Parameters: Nada
     - Returns: Nada
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        pensamentosTextField.layer.borderWidth = 1
        pensamentosTextField.layer.borderColor = UIColor.lightGray.cgColor
        pensamentosTextField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        pensamentosTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        pensamentosTextField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.view.backgroundColor = UIColor(patternImage: imagemBackground)
        
        if memoria?.pensamentos != nil{
            if let memoria = memoria {
                pensamentosTextField.text = memoria.pensamentos
            }
        } else{
            pensamentosTextField.text = "Escreva aqui..."
            pensamentosTextField.textColor = UIColor.lightGray
        }
        
        if memoria?.titulo != nil {
            if let memoria = memoria {
                let nomeImg:String = memoria.titulo ?? "vazio"
                imagemPensamentos.image = UIImage(named: nomeImg)
            }
        } else {
            imagemPensamentos.image = UIImage(named: "vazio")
        }
//        degrede(view: testeView)
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
        if pensamentosTextField.text == "Escreva aqui..."{
            pensamentosTextField.text = ""
            pensamentosTextField.textColor = UIColor.black
        }
    }
    
    /**
    *Verificar se a textView está vazia após edição*
     - Parameters: Nada
     - Returns: Nada
     */
    func textViewDidEndEditing(_ textView: UITextView) {
        if pensamentosTextField.text.isEmpty{
            pensamentosTextField.text = "Escreva aqui..."
            pensamentosTextField.textColor = UIColor.lightGray
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
    
    /**
    *Executar a segue recebida*
    - Parameters:
     - view: uma view do tipo UIView
    - Returns: Nada
    */
    func degrede(view: UIView){
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        let gradientColor = UIColor.white
        gradient.colors = [gradientColor.withAlphaComponent(0.0).cgColor,
                           gradientColor.withAlphaComponent(1.0).cgColor]
        gradient.locations = [NSNumber(value: 0.5), NSNumber(value: 1.0), NSNumber(value: 1.0)]
        gradient.frame = view.bounds
        view.layer.mask = gradient
    }
}
