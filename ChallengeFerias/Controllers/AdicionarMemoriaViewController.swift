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
    var medoClicada:Int = 0
    var aversaoClicada:Int = 0
    
    @IBOutlet weak var buttonAlegria: UIButton!
    
    @IBOutlet weak var buttonTristeza: UIButton!
    
    @IBOutlet weak var buttonRaiva: UIButton!
    
    @IBOutlet weak var buttonMedo: UIButton!
    
    @IBOutlet weak var buttonAversao: UIButton!
    
    @IBOutlet weak var buttonSalvar: UIBarButtonItem!
    
    @IBOutlet weak var labelData: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9294117647, blue: 0.8862745098, alpha: 1)
        
        context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
        sentimentos = []
        buttonSalvar.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        labelData.text = formatarData(date: Date())
    }
    
    // Função para formatar a data para String
    func formatarData(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dataAtual = formatter.string(from: date)
        return dataAtual
    }
    
    @IBAction func ButtonAlegriaClicked(_ sender: Any) {
        
        // Entrar se não estiver clicado
        if alegriaClicada == 0 {
            // Entrar se apenas 0 ou 1 botao clicados
            if contadorBotoesSelecionados < 2 && contadorBotoesSelecionados >= 0 {
                sentimentos.append("alegria")
                alegriaClicada = 1
                contadorBotoesSelecionados += 1
                buttonAlegria.setImage(UIImage(named: "imagemBotaoAlegriaClicada"), for: .normal)
            }
        // Entrar se estiver clicado
        } else {
            while let idx = sentimentos.firstIndex(of:"alegria") {
                sentimentos.remove(at: idx)
            }
            alegriaClicada = 0
            contadorBotoesSelecionados -= 1
            buttonAlegria.setImage(UIImage(named: "imagemBotaoAlegria"), for: .normal)
        }
        mudarImg()
        checarBotaoSalvar()
    }
    
    
    @IBAction func buttonTristezaClicked(_ sender: Any) {

        if tristezaClicada == 0 {
            if contadorBotoesSelecionados < 2 && contadorBotoesSelecionados >= 0 {
                sentimentos.append("tristeza")
                tristezaClicada = 1
                contadorBotoesSelecionados += 1
                buttonTristeza.setImage(UIImage(named: "imagemBotaoTristezaClicada"), for: .normal)
            }
        } else {
            while let idx = sentimentos.firstIndex(of:"tristeza") {
                sentimentos.remove(at: idx)
            }
            tristezaClicada = 0
            contadorBotoesSelecionados -= 1
            buttonTristeza.setImage(UIImage(named: "imagemBotaoTristeza"), for: .normal)
        }
        mudarImg()
        checarBotaoSalvar()
    }
    
    
    @IBAction func buttonRaivaClicked(_ sender: Any) {
        
        if raivaClicada == 0 {
            if contadorBotoesSelecionados < 2 && contadorBotoesSelecionados >= 0 {
                sentimentos.append("raiva")
                raivaClicada = 1
                contadorBotoesSelecionados += 1
                buttonRaiva.setImage(UIImage(named: "imagemBotaoRaivaClicada"), for: .normal)
            }
        } else {
            while let idx = sentimentos.firstIndex(of:"raiva") {
                sentimentos.remove(at: idx)
            }
            raivaClicada = 0
            contadorBotoesSelecionados -= 1
            buttonRaiva.setImage(UIImage(named: "imagemBotaoRaiva"), for: .normal)
        }
        mudarImg()
        checarBotaoSalvar()
    }
    
    
    @IBAction func buttonMedoClicked(_ sender: Any) {
        if medoClicada == 0 {
            if contadorBotoesSelecionados < 2 && contadorBotoesSelecionados >= 0 {
                sentimentos.append("medo")
                medoClicada = 1
                contadorBotoesSelecionados += 1
                buttonMedo.setImage(UIImage(named: "imagemBotaoMedoClicada"), for: .normal)
            }
        } else {
            while let idx = sentimentos.firstIndex(of:"medo") {
                sentimentos.remove(at: idx)
            }
            medoClicada = 0
            contadorBotoesSelecionados -= 1
            buttonMedo.setImage(UIImage(named: "imagemBotaoMedo"), for: .normal)
        }
        mudarImg()
        checarBotaoSalvar()
    }
    
    @IBAction func buttonAversaoClicked(_ sender: Any) {
        if aversaoClicada == 0 {
            if contadorBotoesSelecionados < 2 && contadorBotoesSelecionados >= 0 {
                sentimentos.append("aversao")
                aversaoClicada = 1
                contadorBotoesSelecionados += 1
                buttonAversao.setImage(UIImage(named: "imagemBotaoAversaoClicada"), for: .normal)
            }
        } else {
            while let idx = sentimentos.firstIndex(of:"aversao") {
                sentimentos.remove(at: idx)
            }
            aversaoClicada = 0
            contadorBotoesSelecionados -= 1
            buttonAversao.setImage(UIImage(named: "imagemBotaoAversao"), for: .normal)
        }
        mudarImg()
        checarBotaoSalvar()
    }
    
    func checarBotaoSalvar() {
        if contadorBotoesSelecionados > 0 {
            buttonSalvar.isEnabled = true
        }
    }
    
    // Mudar Imagem da Emoção
    func mudarImg() {
        
        //Mudar imagem quando alegria é clicado
        if let index = sentimentos.firstIndex(of: "alegria"){
            if sentimentos.firstIndex(of: "tristeza") != nil{
                imagemEmocao?.image = UIImage(named: "alegriaTristeza")
            } else if sentimentos.firstIndex(of: "raiva") != nil {
                imagemEmocao?.image = UIImage(named: "alegriaRaiva")
            } else if sentimentos.firstIndex(of: "medo") != nil {
                imagemEmocao?.image = UIImage(named: "alegriaMedo")
            } else if sentimentos.firstIndex(of: "aversao") != nil {
                imagemEmocao?.image = UIImage(named: "alegriaAversao")
            } else {
                imagemEmocao?.image = UIImage(named: "alegria")
            }
        }
        
        // Mudar imagem quando Tristeza é clicado
        else if let index = sentimentos.firstIndex(of: "tristeza"){
            if sentimentos.firstIndex(of: "alegria") != nil{
                imagemEmocao?.image = UIImage(named: "alegriaTristeza")
            } else if sentimentos.firstIndex(of: "raiva") != nil {
                imagemEmocao?.image = UIImage(named: "tristezaRaiva")
            } else if sentimentos.firstIndex(of: "medo") != nil {
                imagemEmocao?.image = UIImage(named: "tristezaMedo")
            } else if sentimentos.firstIndex(of: "aversao") != nil {
                imagemEmocao?.image = UIImage(named: "tristezaAversao")
            } else {
                imagemEmocao?.image = UIImage(named: "tristeza")
            }
        }
        
        // Mudar imagem quando raiva é clicada
        else if let index = sentimentos.firstIndex(of: "raiva") {
            if sentimentos.firstIndex(of: "alegria") != nil{
                imagemEmocao?.image = UIImage(named: "alegriaRaiva")
            } else if sentimentos.firstIndex(of: "tristeza") != nil {
                imagemEmocao?.image = UIImage(named: "tristezaRaiva")
            } else if sentimentos.firstIndex(of: "medo") != nil {
                imagemEmocao?.image = UIImage(named: "raivaMedo")
            } else if sentimentos.firstIndex(of: "aversao") != nil {
                imagemEmocao?.image = UIImage(named: "raivaAversao")
            } else {
                imagemEmocao?.image = UIImage(named: "raiva")
            }
        }
        
        // Mudar imagem quando medo é clicada
        else if let index = sentimentos.firstIndex(of: "medo"){
            if sentimentos.firstIndex(of: "alegria") != nil{
                imagemEmocao?.image = UIImage(named: "alegriaMedo")
            } else if sentimentos.firstIndex(of: "tristeza") != nil {
                imagemEmocao?.image = UIImage(named: "tristezaMedo")
            } else if sentimentos.firstIndex(of: "raiva") != nil {
                imagemEmocao?.image = UIImage(named: "raivaMedo")
            } else if sentimentos.firstIndex(of: "aversao") != nil {
                imagemEmocao?.image = UIImage(named: "medoAversao")
            } else {
                imagemEmocao?.image = UIImage(named: "medo")
            }
        }
        
        // Mudar imagem quando aversao é clicada
        else if let index = sentimentos.firstIndex(of: "aversao"){
            if sentimentos.firstIndex(of: "alegria") != nil{
                imagemEmocao?.image = UIImage(named: "alegriaAversao")
            } else if sentimentos.firstIndex(of: "tristeza") != nil {
                imagemEmocao?.image = UIImage(named: "tristezaAversao")
            } else if sentimentos.firstIndex(of: "medo") != nil {
                imagemEmocao?.image = UIImage(named: "medoAversao")
            } else if sentimentos.firstIndex(of: "raiva") != nil {
                imagemEmocao?.image = UIImage(named: "raivaAversao")
            } else {
                imagemEmocao?.image = UIImage(named: "aversao")
            }
        }
        
        else {
            imagemEmocao?.image = UIImage(named: "vazio")
        }
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let context = context{
            novaMemoria = (NSEntityDescription.insertNewObject(forEntityName: "Memoria", into: context) as! Memoria)
            
            for x in sentimentos{
                let sentimento = (NSEntityDescription.insertNewObject(forEntityName: "Sentimento", into: context) as! Sentimento)
                sentimento.nome = x
                novaMemoria?.addToTem(sentimento)
            }
            
            novaMemoria?.data = Date() as NSDate
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            return true
        }
        return false
    }

    
}
