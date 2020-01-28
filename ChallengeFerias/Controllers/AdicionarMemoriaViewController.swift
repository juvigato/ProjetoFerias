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
    
    var imagemBackground:UIImage = UIImage(named: "backgroundClaro.png") ?? UIImage()
    
//    var imagemBackgroundCinza:UIImage = UIImage(named: "backgroundClaroCinza.png") ?? UIImage()
    
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
    
    @IBOutlet weak var lblButtonAlegria: UILabel!
    
    @IBOutlet weak var lblButtonTristeza: UILabel!
    
    @IBOutlet weak var lblButtonRaiva: UILabel!
    
    @IBOutlet weak var lblButtonMedo: UILabel!
    
    @IBOutlet weak var lblButtonAversao: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        sentimentos = []
        buttonSalvar.isEnabled = false
        checarTema()
        self.view.backgroundColor = UIColor(patternImage: imagemBackground)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        labelData.text = formatarData(date: Date())
    }
    
    /**
    *Checar o tema para que as imagens e textos sejam do tema selecionado*
     - Parameters: Nada
     - Returns: Nada
     */
    func checarTema() {
        if UserDefaults.standard.string(forKey: "tema") == "Escala de cinza" {
            buttonSalvar.tintColor = #colorLiteral(red: 0.1971875429, green: 0.2142196, blue: 0.2370504141, alpha: 1)
            lblButtonAlegria.textColor = #colorLiteral(red: 0.8392156863, green: 0.8352941176, blue: 0.8352941176, alpha: 1)
            lblButtonTristeza.textColor = #colorLiteral(red: 0.7450980392, green: 0.737254902, blue: 0.737254902, alpha: 1)
            lblButtonRaiva.textColor = #colorLiteral(red: 0.3647058824, green: 0.3529411765, blue: 0.3529411765, alpha: 1)
            lblButtonMedo.textColor = #colorLiteral(red: 0.4862745098, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
            lblButtonAversao.textColor = #colorLiteral(red: 0.6156862745, green: 0.6039215686, blue: 0.6039215686, alpha: 1)
            buttonAlegria.setImage(UIImage(named: "imagemBotaoAlegriaCinza"), for: .normal)
            buttonTristeza.setImage(UIImage(named: "imagemBotaoTristezaCinza"), for: .normal)
            buttonRaiva.setImage(UIImage(named: "imagemBotaoRaivaCinza"), for: .normal)
            buttonMedo.setImage(UIImage(named: "imagemBotaoMedoCinza"), for: .normal)
            buttonAversao.setImage(UIImage(named: "imagemBotaoAversaoCinza"), for: .normal)
        } else {
            lblButtonAlegria.textColor = #colorLiteral(red: 1, green: 0.8, blue: 0.2705882353, alpha: 1)
            lblButtonTristeza.textColor = #colorLiteral(red: 0.337254902, green: 0.4980392157, blue: 0.9019607843, alpha: 1)
            lblButtonRaiva.textColor = #colorLiteral(red: 0.9019607843, green: 0.3215686275, blue: 0.2588235294, alpha: 1)
            lblButtonMedo.textColor = #colorLiteral(red: 0.4901960784, green: 0.3921568627, blue: 0.7137254902, alpha: 1)
            lblButtonAversao.textColor = #colorLiteral(red: 0.5960784314, green: 0.8, blue: 0.2901960784, alpha: 1)
            buttonAlegria.setImage(UIImage(named: "imagemBotaoAlegria"), for: .normal)
            buttonTristeza.setImage(UIImage(named: "imagemBotaoTristeza"), for: .normal)
            buttonRaiva.setImage(UIImage(named: "imagemBotaoRaiva"), for: .normal)
            buttonMedo.setImage(UIImage(named: "imagemBotaoMedo"), for: .normal)
            buttonAversao.setImage(UIImage(named: "imagemBotaoAversao"), for: .normal)
        }
    }
    
    /**
    *Função para formatar a data para String*
    - Parameters:
     - date: uma data em formato Date
    - Returns: uma data em formato de String
    */
    func formatarData(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dataAtual = formatter.string(from: date)
        return dataAtual
    }
    
    /**
    *Quando o botão que representa a Alegria for clicado, a imagem do botão irá ser alterada*
    - Parameters:
     - sender: o botão clicado
    - Returns: Nada
    */
    @IBAction func ButtonAlegriaClicked(_ sender: Any) {
        // Entrar se não estiver clicado
        if alegriaClicada == 0 {
            // Entrar se apenas 0 ou 1 botao clicados
            if contadorBotoesSelecionados < 2 && contadorBotoesSelecionados >= 0 {
                sentimentos.append("alegria")
                alegriaClicada = 1
                contadorBotoesSelecionados += 1
                if UserDefaults.standard.string(forKey: "tema") == "Escala de cinza" {
                    buttonAlegria.setImage(UIImage(named: "imagemBotaoAlegriaClicadaCinza"), for: .normal)
                } else {
                    buttonAlegria.setImage(UIImage(named: "imagemBotaoAlegriaClicada"), for: .normal)
                }
            }
        // Entrar se estiver clicado
        } else {
            while let idx = sentimentos.firstIndex(of:"alegria") {
                sentimentos.remove(at: idx)
            }
            alegriaClicada = 0
            contadorBotoesSelecionados -= 1
            if UserDefaults.standard.string(forKey: "tema") == "Escala de cinza" {
                buttonAlegria.setImage(UIImage(named: "imagemBotaoAlegriaCinza"), for: .normal)
            } else {
                buttonAlegria.setImage(UIImage(named: "imagemBotaoAlegria"), for: .normal)
            }
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
                
                if UserDefaults.standard.string(forKey: "tema") == "Escala de cinza" {
                    buttonTristeza.setImage(UIImage(named: "imagemBotaoTristezaClicadaCinza"), for: .normal)
                } else {
                    buttonTristeza.setImage(UIImage(named: "imagemBotaoTristezaClicada"), for: .normal)
                }
            }
        } else {
            while let idx = sentimentos.firstIndex(of:"tristeza") {
                sentimentos.remove(at: idx)
            }
            tristezaClicada = 0
            contadorBotoesSelecionados -= 1
            if UserDefaults.standard.string(forKey: "tema") == "Escala de cinza" {
                buttonTristeza.setImage(UIImage(named: "imagemBotaoTristezaCinza"), for: .normal)
            } else {
                buttonTristeza.setImage(UIImage(named: "imagemBotaoTristeza"), for: .normal)
            }
            
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
                if UserDefaults.standard.string(forKey: "tema") == "Escala de cinza" {
                    buttonRaiva.setImage(UIImage(named: "imagemBotaoRaivaClicadaCinza"), for: .normal)
                } else {
                    buttonRaiva.setImage(UIImage(named: "imagemBotaoRaivaClicada"), for: .normal)
                }
            }
        } else {
            while let idx = sentimentos.firstIndex(of:"raiva") {
                sentimentos.remove(at: idx)
            }
            raivaClicada = 0
            contadorBotoesSelecionados -= 1
            if UserDefaults.standard.string(forKey: "tema") == "Escala de cinza" {
                buttonRaiva.setImage(UIImage(named: "imagemBotaoRaivaCinza"), for: .normal)
            } else {
                buttonRaiva.setImage(UIImage(named: "imagemBotaoRaiva"), for: .normal)            }
            
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
                if UserDefaults.standard.string(forKey: "tema") == "Escala de cinza" {
                    buttonMedo.setImage(UIImage(named: "imagemBotaoMedoClicadaCinza"), for: .normal)
                } else {
                    buttonMedo.setImage(UIImage(named: "imagemBotaoMedoClicada"), for: .normal)
                }
            }
        } else {
            while let idx = sentimentos.firstIndex(of:"medo") {
                sentimentos.remove(at: idx)
            }
            medoClicada = 0
            contadorBotoesSelecionados -= 1
            
            if UserDefaults.standard.string(forKey: "tema") == "Escala de cinza" {
                buttonMedo.setImage(UIImage(named: "imagemBotaoMedoCinza"), for: .normal)
            } else {
                buttonMedo.setImage(UIImage(named: "imagemBotaoMedo"), for: .normal)
            }
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
                
                if UserDefaults.standard.string(forKey: "tema") == "Escala de cinza" {
                    buttonAversao.setImage(UIImage(named: "imagemBotaoAversaoClicadaCinza"), for: .normal)
                } else {
                    buttonAversao.setImage(UIImage(named: "imagemBotaoAversaoClicada"), for: .normal)
                }
            }
        } else {
            while let idx = sentimentos.firstIndex(of:"aversao") {
                sentimentos.remove(at: idx)
            }
            aversaoClicada = 0
            contadorBotoesSelecionados -= 1
            
            if UserDefaults.standard.string(forKey: "tema") == "Escala de cinza" {
                buttonAversao.setImage(UIImage(named: "imagemBotaoAversaoCinza"), for: .normal)
            } else {
                buttonAversao.setImage(UIImage(named: "imagemBotaoAversao"), for: .normal)
            }
        }
        mudarImg()
        checarBotaoSalvar()
    }
    
    func checarBotaoSalvar() {
        if contadorBotoesSelecionados > 0 {
            buttonSalvar.isEnabled = true
        }
        else {
            buttonSalvar.isEnabled = false
        }
    }
    
    // Mudar Imagem da Emoção
    func mudarImg() {
        
        var titulo:String = ""
        
        if UserDefaults.standard.string(forKey: "tema") == "Original" {
            //Mudar imagem quando alegria é clicado
            if sentimentos.firstIndex(of: "alegria") != nil{
                if sentimentos.firstIndex(of: "tristeza") != nil{
                    titulo = "alegriaTristeza"
                } else if sentimentos.firstIndex(of: "raiva") != nil {
                    titulo = "alegriaRaiva"
                } else if sentimentos.firstIndex(of: "medo") != nil {
                    titulo = "alegriaMedo"
                } else if sentimentos.firstIndex(of: "aversao") != nil {
                    titulo = "alegriaAversao"
                } else {
                    titulo = "alegria"
                }
            }
            
            // Mudar imagem quando Tristeza é clicado
            else if sentimentos.firstIndex(of: "tristeza") != nil{
                if sentimentos.firstIndex(of: "alegria") != nil{
                    titulo = "alegriaTristeza"
                } else if sentimentos.firstIndex(of: "raiva") != nil {
                    titulo = "tristezaRaiva"
                } else if sentimentos.firstIndex(of: "medo") != nil {
                    titulo = "tristezaMedo"
                } else if sentimentos.firstIndex(of: "aversao") != nil {
                    titulo = "tristezaAversao"
                } else {
                    titulo = "tristeza"
                }
            }
            
            // Mudar imagem quando raiva é clicada
            else if let index = sentimentos.firstIndex(of: "raiva") {
                if sentimentos.firstIndex(of: "alegria") != nil{
                    titulo = "alegriaRaiva"
                } else if sentimentos.firstIndex(of: "tristeza") != nil {
                    titulo = "tristezaRaiva"
                } else if sentimentos.firstIndex(of: "medo") != nil {
                    titulo = "raivaMedo"
                } else if sentimentos.firstIndex(of: "aversao") != nil {
                    titulo = "raivaAversao"
                } else {
                    titulo = "raiva"
                }
            }
            
            // Mudar imagem quando medo é clicada
            else if let index = sentimentos.firstIndex(of: "medo"){
                if sentimentos.firstIndex(of: "alegria") != nil{
                    titulo = "alegriaMedo"
                } else if sentimentos.firstIndex(of: "tristeza") != nil {
                    titulo = "tristezaMedo"
                } else if sentimentos.firstIndex(of: "raiva") != nil {
                    titulo = "raivaMedo"
                } else if sentimentos.firstIndex(of: "aversao") != nil {
                    titulo = "medoAversao"
                } else {
                    titulo = "medo"
                }
            }
            
            // Mudar imagem quando aversao é clicada
            else if let index = sentimentos.firstIndex(of: "aversao"){
                if sentimentos.firstIndex(of: "alegria") != nil{
                    titulo = "alegriaAversao"
                } else if sentimentos.firstIndex(of: "tristeza") != nil {
                    titulo = "tristezaAversao"
                } else if sentimentos.firstIndex(of: "medo") != nil {
                    titulo = "medoAversao"
                } else if sentimentos.firstIndex(of: "raiva") != nil {
                    titulo = "raivaAversao"
                } else {
                    titulo = "aversao"
                }
            }
            
            else {
                titulo = "vazio"
            }
        }
        else if UserDefaults.standard.string(forKey: "tema") == "Escala de cinza" {
            //escala de cinza
            
            //Mudar imagem quando alegria é clicado
            if sentimentos.firstIndex(of: "alegria") != nil{
                if sentimentos.firstIndex(of: "tristeza") != nil{
                    titulo = "alegriaTristezaCinza"
                } else if sentimentos.firstIndex(of: "raiva") != nil {
                    titulo = "alegriaRaivaCinza"
                } else if sentimentos.firstIndex(of: "medo") != nil {
                    titulo = "alegriaMedoCinza"
                } else if sentimentos.firstIndex(of: "aversao") != nil {
                    titulo = "alegriaAversaoCinza"
                } else {
                    titulo = "alegriaCinza"
                }
            }
            
            // Mudar imagem quando Tristeza é clicado
            else if sentimentos.firstIndex(of: "tristeza") != nil{
                if sentimentos.firstIndex(of: "alegria") != nil{
                    titulo = "alegriaTristezaCinza"
                } else if sentimentos.firstIndex(of: "raiva") != nil {
                    titulo = "tristezaRaivaCinza"
                } else if sentimentos.firstIndex(of: "medo") != nil {
                    titulo = "tristezaMedoCinza"
                } else if sentimentos.firstIndex(of: "aversao") != nil {
                    titulo = "tristezaAversaoCinza"
                } else {
                    titulo = "tristezaCinza"
                }
            }
            
            // Mudar imagem quando raiva é clicada
            else if let index = sentimentos.firstIndex(of: "raiva") {
                if sentimentos.firstIndex(of: "alegria") != nil{
                    titulo = "alegriaRaivaCinza"
                } else if sentimentos.firstIndex(of: "tristeza") != nil {
                    titulo = "tristezaRaivaCinza"
                } else if sentimentos.firstIndex(of: "medo") != nil {
                    titulo = "raivaMedoCinza"
                } else if sentimentos.firstIndex(of: "aversao") != nil {
                    titulo = "raivaAversaoCinza"
                } else {
                    titulo = "raivaCinza"
                }
            }
            
            // Mudar imagem quando medo é clicada
            else if let index = sentimentos.firstIndex(of: "medo"){
                if sentimentos.firstIndex(of: "alegria") != nil{
                    titulo = "alegriaMedoCinza"
                } else if sentimentos.firstIndex(of: "tristeza") != nil {
                    titulo = "tristezaMedoCinza"
                } else if sentimentos.firstIndex(of: "raiva") != nil {
                    titulo = "raivaMedoCinza"
                } else if sentimentos.firstIndex(of: "aversao") != nil {
                    titulo = "medoAversaoCinza"
                } else {
                    titulo = "medoCinza"
                }
            }
            
            // Mudar imagem quando aversao é clicada
            else if let index = sentimentos.firstIndex(of: "aversao"){
                if sentimentos.firstIndex(of: "alegria") != nil{
                    titulo = "alegriaAversaoCinza"
                } else if sentimentos.firstIndex(of: "tristeza") != nil {
                    titulo = "tristezaAversaoCinza"
                } else if sentimentos.firstIndex(of: "medo") != nil {
                    titulo = "medoAversaoCinza"
                } else if sentimentos.firstIndex(of: "raiva") != nil {
                    titulo = "raivaAversaoCinza"
                } else {
                    titulo = "aversaoCinza"
                }
            }
            
            else {
                titulo = "vazioCinza"
            }
        }
        
        imagemEmocao?.image = UIImage(named: titulo)
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
