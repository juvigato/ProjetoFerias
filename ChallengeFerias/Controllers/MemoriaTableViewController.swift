//
//  ViewController.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 12/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import UIKit
import CoreData


class MemoriaTableViewController: UITableViewController {
    
    public var memoria:Memoria?
    
    public var timelineTVC: TimelineMemoriasController?
    
    var context: NSManagedObjectContext?
    
    @IBOutlet weak var imagemMemoria: UIImageView!
    
    @IBOutlet weak var tituloFoto: UILabel!
    
    @IBOutlet weak var dataText: UILabel!
    
    var imagemBackground:UIImage = UIImage(named: "backgroundClaro.jpg") ?? UIImage()
    
    var dicionarioNomesOriginal: [String:String] = ["alegria": "Alegria",
                                                    "tristeza": "Tristeza",
                                                    "raiva": "Raiva",
                                                    "medo": "Medo",
                                                    "aversao": "Aversão",
                                                    "alegriaTristeza": "Alegria e Tristeza",
                                                    "alegriaRaiva": "Alegria e Raiva",
                                                    "alegriaMedo": "Alegria e Medo",
                                                    "alegriaAversao": "Alegria e Aversão",
                                                    "tristezaRaiva": "Tristeza e Raiva",
                                                    "tristezaMedo": "Tristeza e Medo",
                                                    "tristezaAversao": "Tristeza e Aversão",
                                                    "raivaMedo": "Raiva e Medo",
                                                    "raivaAversao": "Raiva e Aversão",
                                                    "medoAversao": "Medo e Aversão",
                                                    "alegriaCinza": "Alegria",
                                                    "tristezaCinza": "Tristeza",
                                                    "raivaCinza": "Raiva",
                                                    "medoCinza": "Medo",
                                                    "aversaoCinza": "Aversão",
                                                    "alegriaTristezaCinza": "Alegria e Tristeza",
                                                    "alegriaRaivaCinza": "Alegria e Raiva",
                                                    "alegriaMedoCinza": "Alegria e Medo",
                                                    "alegriaAversaoCinza": "Alegria e Aversão",
                                                    "tristezaRaivaCinza": "Tristeza e Raiva",
                                                    "tristezaMedoCinza": "Tristeza e Medo",
                                                    "tristezaAversaoCinza": "Tristeza e Aversão",
                                                    "raivaMedoCinza": "Raiva e Medo",
                                                    "raivaAversaoCinza": "Raiva e Aversão",
                                                    "medoAversaoCinza": "Medo e Aversão",
                                                    "alegriaPastel": "Alegria",
                                                    "tristezaPastel": "Tristeza",
                                                    "raivaPastel": "Raiva",
                                                    "medoPastel": "Medo",
                                                    "aversaoPastel": "Aversão",
                                                    "alegriaTristezaPastel": "Alegria e Tristeza",
                                                    "alegriaRaivaPastel": "Alegria e Raiva",
                                                    "alegriaMedoPastel": "Alegria e Medo",
                                                    "alegriaAversaoPastel": "Alegria e Aversão",
                                                    "tristezaRaivaPastel": "Tristeza e Raiva",
                                                    "tristezaMedoPastel": "Tristeza e Medo",
                                                    "tristezaAversaoPastel": "Tristeza e Aversão",
                                                    "raivaMedoPastel": "Raiva e Medo",
                                                    "raivaAversaoPastel": "Raiva e Aversão",
                                                    "medoAversaoPastel": "Medo e Aversão"]
    
    let arrayNomesOriginal = ["alegria", "tristeza", "raiva", "medo", "aversao", "alegriaTristeza", "alegriaRaiva", "alegriaMedo", "alegriaAversao", "tristezaRaiva", "tristezaMedo", "tristezaAversao", "raivaMedo", "raivaAversao", "medoAversao", "alegriaCinza", "tristezaCinza", "raivaCinza", "medoCinza", "aversaoCinza", "alegriaTristezaCinza", "alegriaRaivaCinza", "alegriaMedoCinza", "alegriaAversaoCinza", "tristezaRaivaCinza", "tristezaMedoCinza", "tristezaAversaoCinza", "raivaMedoCinza", "raivaAversaoCinza", "medoAversaoCinza", "alegriaPastel", "tristezaPastel", "raivaPastel", "medoPastel", "aversaoPastel", "alegriaTristezaPastel", "alegriaRaivaPastel", "alegriaMedoPastel", "alegriaAversaoPastel", "tristezaRaivaPastel", "tristezaMedoPastel", "tristezaAversaoPastel", "raivaMedoPastel", "raivaAversaoPastel", "medoAversaoPastel"]
    
    /**
    *Carregar  todas características necessárias da tela*
     - Parameters: Nada
     - Returns: Nada
     */
    override func viewDidLoad() {
        carregarDadosMemoria()
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.view.backgroundColor = UIColor(patternImage: imagemBackground)
    }
    
    /**
    *Detecta qual linha foi selecionada*
     - Parameters:
      - tableView: tableView que aparecerá na tela
      - indexPath: index da célula da tableView
     - Returns: Nada
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            performSegue(withIdentifier: "editarSituacao", sender: nil)
        } else if indexPath.row == 2{
            performSegue(withIdentifier: "editarPensamentos", sender: nil)
        } else if indexPath.row == 3{
            performSegue(withIdentifier: "editarAtitude", sender: nil)
        } else if indexPath.row == 4{
            performSegue(withIdentifier: "editarResultado", sender: nil)
        }
    }
    
    /**
    *Ação que da seguimento a alguma tela, ou seja, ao clicar neste botão, o aplicativo vai para a tela anterior e salva os dados modificados na tela atual*
     - Parameters:
      - sender: determinada segue
     - Returns: Nada
     */
    @IBAction func salvarBotao(_ sender: UIStoryboardSegue){
        if sender.source is EditarSituacaoController{
            if let senderAdd = sender.source as? EditarSituacaoController{
                if let situacao = senderAdd.situacaoText{
                    memoria?.situacao = situacao
                }
            }
        }
        
        if sender.source is EditarPensamentosController{
            if let senderAdd = sender.source as? EditarPensamentosController{
                if let pensamentos = senderAdd.pensamentosText{
                    memoria?.pensamentos = pensamentos
                }
            }
        }
        
        if sender.source is EditarAtitudeController{
            if let senderAdd = sender.source as? EditarAtitudeController{
                if let atitude = senderAdd.atitudeText{
                    memoria?.atitude = atitude
                }
            }
        }
        
        if sender.source is EditarResultadoController{
            if let senderAdd = sender.source as? EditarResultadoController{
                if let resultado = senderAdd.resultadoText{
                    memoria?.resultado = resultado
                }
            }
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }

    /**
    *Preparar a tela que virá a seguir*
     - Parameters:
      - segue: segue do storyboard
      - sender: algum gatilho do storyboard
     - Returns: Nada
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let situacaoTVC = segue.destination as? EditarSituacaoController{
            if segue.identifier == "editarSituacao"{
                if let indexPath = tableView.indexPathForSelectedRow{
                    let memoriaTemp = memoria
                    situacaoTVC.memoria = memoriaTemp
                }
            }
        }
        if let pensamentosTVC = segue.destination as? EditarPensamentosController{
            if segue.identifier == "editarPensamentos"{
                if let indexPath = tableView.indexPathForSelectedRow{
                    let memoriaTemp = memoria
                    pensamentosTVC.memoria = memoriaTemp
                }
            }
        }
        if let atitudeTVC = segue.destination as? EditarAtitudeController{
            if segue.identifier == "editarAtitude"{
                if let indexPath = tableView.indexPathForSelectedRow{
                    let memoriaTemp = memoria
                    atitudeTVC.memoria = memoriaTemp
                }
            }
        }
        if let resultadoTVC = segue.destination as? EditarResultadoController{
            if segue.identifier == "editarResultado"{
                if let indexPath = tableView.indexPathForSelectedRow{
                    let memoriaTemp = memoria
                    resultadoTVC.memoria = memoriaTemp
                }
            }
        }
    }
    
    /**
    *Carregar imagem, titulo e data da imagem*
     - Parameters: Nada
     - Returns: Nada
     */
    func carregarDadosMemoria(){
        imagemMemoria.image = UIImage(named: memoria?.titulo ?? "vazio")
        tituloFoto.text = memoria?.titulo
        formatarNomeImg()
        if memoria?.data != nil {
            dataText.text = formatarData(date: memoria?.data as! Date)
        } else{
            dataText.text = "Sem data"
        }
    }
    
    /**
    *Formatar nome da imagem, ao recuperar o elemento titulo que a memória possui*
     - Parameters: Nada
     - Returns: Nada
     */
    func formatarNomeImg() {
        for nome in arrayNomesOriginal {
            if let titulo = dicionarioNomesOriginal[nome]{
                if memoria?.titulo == nome {
                    tituloFoto.text = titulo
                }
            } else {
                print("error")
            }
        }
    }
    
    /**
    *Formatar data*
     - Parameters:
      - date: data em formato Date
     - Returns:data em formato de String
     */
    func formatarData(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dataAtual = formatter.string(from: date)
        return dataAtual
    }
}
