//
//  AdicionarMemoriaViewController.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 16/01/20.
//  Copyright © 2020 Juliana Vigato Pavan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class AdicionarMemoriaViewController: UIViewController{
    
    var context:NSManagedObjectContext?
    
    var novaMemoria:Memoria?
    
    var sentimentos:[String] = []
    
    @IBOutlet weak var imagemEmocao: UIImageView?
    
    var contadorBotoesSelecionados:Int = 0
    
    var alegriaClicada:Int = 0
    var tristezaClicada:Int = 0
    var raivaClicada:Int = 0
    
//    var sentimento1:String = ""
//    var sentimento2:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9294117647, blue: 0.8862745098, alpha: 1)
        
        context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
        sentimentos = []
    }
    
    @IBAction func ButtonAlegriaClicked(_ sender: Any) {
        
        if contadorBotoesSelecionados <= 2 {
            if alegriaClicada == 0 {
                print("alegria")
                sentimentos.append("alegria")
                alegriaClicada = 1
                contadorBotoesSelecionados += 1
                
            } else {
                while let idx = sentimentos.firstIndex(of:"alegria") {
                    sentimentos.remove(at: idx)
                }
                alegriaClicada = 0
                print("saiu alegria")
                contadorBotoesSelecionados -= 1
            }
        }
        mudarImg()
    }
    
    
    @IBAction func buttonTristezaClicked(_ sender: Any) {
        if contadorBotoesSelecionados <= 2 {
            if tristezaClicada == 0 {
                print("tristeza")
                sentimentos.append("tristeza")
                tristezaClicada = 1
                contadorBotoesSelecionados += 1
            } else {
                while let idx = sentimentos.firstIndex(of:"tristeza") {
                    sentimentos.remove(at: idx)
                }
                tristezaClicada = 0
                print("saiu tristeza")
                contadorBotoesSelecionados -= 1
            }
        }
        mudarImg()
    }
    
    
    @IBAction func ButtonRaivaClicked(_ sender: Any) {
        if contadorBotoesSelecionados <= 2 {
            if raivaClicada == 0 {
                print("raiva")
                sentimentos.append("raiva")
                raivaClicada = 1
                contadorBotoesSelecionados += 1
            } else {
                while let idx = sentimentos.firstIndex(of:"raiva") {
                    sentimentos.remove(at: idx)
                }
                raivaClicada = 0
                print("saiu raiva")
                contadorBotoesSelecionados -= 1
            }
        }
        mudarImg()
    }
    
    // Mudar Imagem da Emoção
    func mudarImg() {
        
        //Mudar imagem quando alegria é clicado
        if let index = sentimentos.firstIndex(of: "alegria"){
            if sentimentos.firstIndex(of: "tristeza") != nil{
                imagemEmocao?.image = #imageLiteral(resourceName: "AlegriaTristeza")
            } else if sentimentos.firstIndex(of: "raiva") != nil {
                imagemEmocao?.image = #imageLiteral(resourceName: "AlegriaRaiva")
            } else if sentimentos.firstIndex(of: "medo") != nil {
                imagemEmocao?.image = #imageLiteral(resourceName: "AlegriaMedo")
            } else if sentimentos.firstIndex(of: "aversao") != nil {
                imagemEmocao?.image = #imageLiteral(resourceName: "AlegriaAversao")
            } else {
                imagemEmocao?.image = UIImage(named: "alegria")
            }
        }
        
        // Mudar imagem quando Tristeza é clicado
        else if let index = sentimentos.firstIndex(of: "tristeza"){
            if sentimentos.firstIndex(of: "alegria") != nil{
                imagemEmocao?.image = #imageLiteral(resourceName: "AlegriaTristeza")
            } else if sentimentos.firstIndex(of: "raiva") != nil {
                imagemEmocao?.image = #imageLiteral(resourceName: "TristezaRaiva")
            } else if sentimentos.firstIndex(of: "medo") != nil {
                imagemEmocao?.image = #imageLiteral(resourceName: "TristezaMedo")
            } else if sentimentos.firstIndex(of: "aversao") != nil {
                imagemEmocao?.image = #imageLiteral(resourceName: "TristezaAversao")
            } else {
                imagemEmocao?.image = UIImage(named: "tristeza")
            }
        }
        
        // Mudar imagem quando raiva é clicada
        else if let index = sentimentos.firstIndex(of: "raiva") {
            if sentimentos.firstIndex(of: "alegria") != nil{
                imagemEmocao?.image = #imageLiteral(resourceName: "AlegriaRaiva")
            } else if sentimentos.firstIndex(of: "tristeza") != nil {
                imagemEmocao?.image = #imageLiteral(resourceName: "TristezaRaiva")
            } else if sentimentos.firstIndex(of: "medo") != nil {
                imagemEmocao?.image = #imageLiteral(resourceName: "RaivaMedo")
            } else if sentimentos.firstIndex(of: "aversao") != nil {
                imagemEmocao?.image = #imageLiteral(resourceName: "RaivaAversao")
            } else {
                imagemEmocao?.image = UIImage(named: "raiva")
            }
        }
        
        // Mudar imagem quando medo é clicada
        else if let index = sentimentos.firstIndex(of: "medo"){
            if sentimentos.firstIndex(of: "alegria") != nil{
                imagemEmocao?.image = #imageLiteral(resourceName: "AlegriaMedo")
            } else if sentimentos.firstIndex(of: "tristeza") != nil {
                imagemEmocao?.image = #imageLiteral(resourceName: "TristezaMedo")
            } else if sentimentos.firstIndex(of: "raiva") != nil {
                imagemEmocao?.image = #imageLiteral(resourceName: "RaivaMedo")
            } else if sentimentos.firstIndex(of: "aversao") != nil {
                imagemEmocao?.image = #imageLiteral(resourceName: "MedoAversao")
            } else {
                imagemEmocao?.image = #imageLiteral(resourceName: "medo")
            }
        }
        
        // Mudar imagem quando aversao é clicada
        else if let index = sentimentos.firstIndex(of: "aversao"){
            if sentimentos.firstIndex(of: "alegria") != nil{
                imagemEmocao?.image = #imageLiteral(resourceName: "AlegriaAversao")
            } else if sentimentos.firstIndex(of: "tristeza") != nil {
                imagemEmocao?.image = #imageLiteral(resourceName: "TristezaAversao")
            } else if sentimentos.firstIndex(of: "medo") != nil {
                imagemEmocao?.image = #imageLiteral(resourceName: "MedoAversao")
            } else if sentimentos.firstIndex(of: "raiva") != nil {
                imagemEmocao?.image = #imageLiteral(resourceName: "RaivaAversao")
            } else {
                imagemEmocao?.image = #imageLiteral(resourceName: "aversao")
            }
        }
    }
    
    
}
