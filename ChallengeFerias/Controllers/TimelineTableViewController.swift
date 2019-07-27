//
//  TimelineTableViewController.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 24/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import UserNotifications

class TimelineMemoriasController: UITableViewController{
    
    public var memorias:[Memoria] = []
    
    var context:NSManagedObjectContext?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 171
        carregarMemorias()
        notificacao()
//        tableView.reloadData()
    }
    
    //pegar as memorias que existem
    func carregarMemorias(){
        do{
            memorias = try context!.fetch(Memoria.fetchRequest())
        } catch {
            print("Falha na Timeline")
            return
        }
        tableView.reloadData()
    }
    
    //numero de linhas
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memorias.count
    }
    
    //metodo que permite a acao de saida
    @IBAction func addMemoria(_ sender: UIStoryboardSegue){
        if sender.source is NovaMemoriaViewController{
            if let senderAdd = sender.source as? NovaMemoriaViewController{
                if let nova = senderAdd.novaMemoria{
                    carregarMemorias()
                    tableView.reloadData()
                    //noPartyImage.removeFromSuperview()
                }
            }
        }
    }
    
    //carregar as células
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath) as! MemoriaTableViewCelula

        celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Alegria-Tristeza – 4")
        celula.situacaoMemoriaTimeline.text = memorias[indexPath.row].situacao
        
        var titulo:String = ""
        
        let x:Sentimento = memorias[indexPath.row].tem![0] as! Sentimento

        
        if (memorias[indexPath.row].tem!.count) > 1 {
            let y:Sentimento = memorias[indexPath.row].tem![1] as! Sentimento
            if (x.nome != nil || y.nome != nil){
                if x.nome == "Alegria" && y.nome == "tristeza"{
                    titulo = "Alegria/Tristeza"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Alegria-TristezaT")
                } else if x.nome == "Alegria" && y.nome == "raiva"{
                    titulo = "Alegria/Raiva"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Alegria-RaivaT")
                } else if x.nome == "Alegria" && y.nome == "medo"{
                    titulo = "Alegria/Medo"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Alegria-MedoT")
                } else if x.nome == "Alegria" && y.nome == "aversao"{
                    titulo = "Alegria/Aversão"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Alegria-AversaoT")
                } else if x.nome == "tristeza" && y.nome == "raiva"{
                    titulo = "Tristeza/Raiva"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Tristeza-RaivaT")
                } else if x.nome == "tristeza" && y.nome == "medo"{
                    titulo = "Tristeza/Medo"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Tristeza-MedoT")
                } else if x.nome == "tristeza" && y.nome == "aversão"{
                    titulo = "Tristeza/Aversão"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Tristeza-AversaoT")
                } else if x.nome == "raiva" && y.nome == "medo"{
                    titulo = "Raiva/Medo"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Raiva-MedoT")
                } else if x.nome == "raiva" && y.nome == "aversao"{
                    titulo = "Raiva/Aversão"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Raiva-AversaoT")
                } else if x.nome == "medo" && y.nome == "aversao"{
                    titulo = "Medo/Aversão"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Medo-AversaoT")
                }
            }
        } else{
            if x.nome == "Alegria" {
                titulo = "Alegria"
                celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "alegriaT")
            } else if x.nome == "tristeza" {
                titulo = "Tristeza"
                celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "tristezaT")
            } else if x.nome == "raiva" {
                titulo = "Raiva"
                celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "raivaT")
            } else if x.nome == "medo" {
                titulo = "Medo"
                celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "medoT")
            } else if x.nome == "aversao" {
                titulo = "Aversão"
                celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "aversaoT")
            }

        }
        
        celula.emocaoMemoriaTimeline.text = titulo
        return celula
    }
    
    func prepararTitulo(indexPath:IndexPath){
        
        
//        memorias[indexPath.row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let memoriaTVC = segue.destination as? MemoriaTableViewController{
            if segue.identifier == "detalhesMemoria"{
                if let indexPath = tableView.indexPathForSelectedRow{
                    var memoriaTemp = memorias[indexPath.row]
                    memoriaTVC.memoria = memoriaTemp
                }
                
            }
        }
    }
    
    
    
    //notificacoes
    func notificacao(){
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings{ (settings) in
            if settings.authorizationStatus == .authorized{
                let content = UNMutableNotificationContent()
                content.title = NSString.localizedUserNotificationString(forKey: "Opa, você não se esqueceu de mim, certo?", arguments: nil)
                content.body = NSString.localizedUserNotificationString(forKey: "Lembre-se de adicionar mais memórias!", arguments: nil)
                content.sound = UNNotificationSound.default
    
                let date = Date(timeIntervalSinceNow: 3600 )
                let triggerDiario = Calendar.current.dateComponents([.day, .hour,.minute,.second], from: date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDiario, repeats: true)
                
//                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: false)
    
                let request = UNNotificationRequest(identifier: "diario", content: content, trigger: trigger)
    
                let center = UNUserNotificationCenter.current()
                    center.add(request) { (error: Error?) in
                    if let error = error{
                        print(error.localizedDescription)
                    }
                }
            } else {
                print("Permissão negada - notificações desativadas")
            }
        }
    }
    

}

