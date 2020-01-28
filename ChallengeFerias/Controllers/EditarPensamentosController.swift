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
    
//    @IBOutlet weak var testeView: UIView!
    
    // outlet imagem
    @IBOutlet weak var imagemPensamentos: UIImageView!
    
    var imagemBackground:UIImage = UIImage(named: "backgroundClaro.jpg") ?? UIImage()
    
//    var imagemBackgroundCinza:UIImage = UIImage(named: "backgroundClaroCinza.jpg") ?? UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pensamentosTextField.layer.borderWidth = 1
        pensamentosTextField.layer.borderColor = UIColor.lightGray.cgColor
        pensamentosTextField.delegate = self
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
    
    func degrede(view: UIView){
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        let gradientColor = UIColor.white
        gradient.colors = [gradientColor.withAlphaComponent(0.0).cgColor, gradientColor.withAlphaComponent(1.0).cgColor]
        gradient.locations = [NSNumber(value: 0.5), NSNumber(value: 1.0), NSNumber(value: 1.0)]
        gradient.frame = view.bounds
        view.layer.mask = gradient
    }
}
