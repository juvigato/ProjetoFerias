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
    
    override func viewDidLoad() {
        carregarImgMemoria()
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

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
    
    func carregarImgMemoria(){
        if memoria?.titulo == "Alegria"{
            imagemMemoria.image = #imageLiteral(resourceName: "alegriaT")
        } else if memoria?.titulo == "Tristeza"{
            imagemMemoria.image = #imageLiteral(resourceName: "tristezaT")
        } else if memoria?.titulo == "Raiva"{
            imagemMemoria.image = #imageLiteral(resourceName: "raivaT")
        } else if memoria?.titulo == "Medo"{
            imagemMemoria.image = #imageLiteral(resourceName: "medoT")
        } else if memoria?.titulo == "Aversão"{
            imagemMemoria.image = #imageLiteral(resourceName: "aversaoT")
        } else if memoria?.titulo == "Alegria/Tristeza"{
            imagemMemoria.image = #imageLiteral(resourceName: "Alegria-TristezaT")
        } else if memoria?.titulo == "Alegria/Raiva"{
            imagemMemoria.image = #imageLiteral(resourceName: "Alegria-RaivaT")
        } else if memoria?.titulo == "Alegria/Medo"{
            imagemMemoria.image = #imageLiteral(resourceName: "Alegria-MedoT")
        } else if memoria?.titulo == "Alegria/Aversão"{
            imagemMemoria.image = #imageLiteral(resourceName: "Alegria-AversaoT")
        } else if memoria?.titulo == "Tristeza/Raiva"{
            imagemMemoria.image = #imageLiteral(resourceName: "Tristeza-RaivaT")
        } else if memoria?.titulo == "Tristeza/Medo"{
            imagemMemoria.image = #imageLiteral(resourceName: "Tristeza-MedoT")
        } else if memoria?.titulo == "Tristeza/Aversão"{
            imagemMemoria.image = #imageLiteral(resourceName: "Tristeza-AversaoT")
        } else if memoria?.titulo == "Raiva/Medo"{
            imagemMemoria.image = #imageLiteral(resourceName: "Raiva-MedoT")
        } else if memoria?.titulo == "Raiva/Aversão"{
            imagemMemoria.image = #imageLiteral(resourceName: "Raiva-AversaoT")
        } else if memoria?.titulo == "Medo/Aversão"{
            imagemMemoria.image = #imageLiteral(resourceName: "Medo-AversaoT")
        }
        tituloFoto.text = memoria?.titulo
        if memoria?.data != nil {
            dataText.text = formatarData(date: memoria?.data as! Date)
        } else{
            dataText.text = "Sem data"
        }
    }
    
    //mudar a data para string
    func formatarData(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dataAtual = formatter.string(from: date)
        return dataAtual
    }
}

