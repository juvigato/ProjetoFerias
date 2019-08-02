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
    
    var semMemoriaImg:UIImageView = UIImageView(image: UIImage(named: "empty"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 171
        carregarMemorias()
        notificacao()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        carregarMemorias()
        
        if memorias.count == 0 {
            semMemoriaImg.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            self.view.addSubview(semMemoriaImg)
            semMemoriaImg.center.x = self.view.center.x
            semMemoriaImg.center.y = self.view.center.y - 80
        }
        tableView.reloadData()
        tableView.tableFooterView = UIView()
    }
    
    //pegar as memorias que existem
    func carregarMemorias(){
        do{
            memorias = try context!.fetch(Memoria.fetchRequest())
        } catch {
            print("Falha na Timeline")
            return
        }
    }
    
    //numero de linhas
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memorias.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context?.delete(memorias[indexPath.row])
            memorias.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            //adicionar uma imagem se não houver memorias
            if memorias.count == 0 {
                semMemoriaImg.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
                self.view.addSubview(semMemoriaImg)
                semMemoriaImg.center.x = self.view.center.x
                semMemoriaImg.center.y = self.view.center.y - 80
            }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
    }
    
    
    //metodo que permite a acao de saida
    @IBAction func addMemoria(_ sender: UIStoryboardSegue){
        if sender.source is NovaMemoriaViewController{
            if let senderAdd = sender.source as? NovaMemoriaViewController{
                if let nova = senderAdd.novaMemoria{
                    carregarMemorias()
                    tableView.reloadData()
                    semMemoriaImg.removeFromSuperview()
                }
            }
        }
    }
    
    //formatar a data
    func formatarData(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dataAtual = formatter.string(from: date)
        return dataAtual
    }
    
    //carregar as células
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath) as! MemoriaTableViewCelula

        celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Alegria-Tristeza – 4")
        
        if memorias[indexPath.row].situacao == nil{
            celula.situacaoMemoriaTimeline.text = "Adicione mais detalhes..."
        } else{
            celula.situacaoMemoriaTimeline.text = memorias[indexPath.row].situacao
        }
        
        celula.dataText.text = formatarData(date: memorias[indexPath.row].data as! Date)
        
        var titulo:String = ""
        
        let x:Sentimento = memorias[indexPath.row].tem![0] as! Sentimento

        if (memorias[indexPath.row].tem!.count) > 1 {
            let y:Sentimento = memorias[indexPath.row].tem![1] as! Sentimento
            if (x.nome != nil || y.nome != nil){
                if (x.nome == "Alegria" && y.nome == "tristeza") || (x.nome == "tristeza" && y.nome == "Alegria"){
                    titulo = "Alegria/Tristeza"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Alegria-TristezaT")
                } else if (x.nome == "Alegria" && y.nome == "raiva") || (x.nome == "raiva" && y.nome == "Alegria") {
                    titulo = "Alegria/Raiva"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Alegria-RaivaT")
                } else if (x.nome == "Alegria" && y.nome == "medo") || (x.nome == "medo" && y.nome == "Alegria"){
                    titulo = "Alegria/Medo"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Alegria-MedoT")
                } else if x.nome == "Alegria" && y.nome == "aversao" || (x.nome == "aversao" && y.nome == "Alegria"){
                    titulo = "Alegria/Aversão"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Alegria-AversaoT")
                } else if x.nome == "tristeza" && y.nome == "raiva" || (x.nome == "raiva" && y.nome == "tristeza"){
                    titulo = "Tristeza/Raiva"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Tristeza-RaivaT")
                } else if x.nome == "tristeza" && y.nome == "medo" || (x.nome == "medo" && y.nome == "tristeza"){
                    titulo = "Tristeza/Medo"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Tristeza-MedoT")
                } else if x.nome == "tristeza" && y.nome == "aversao" || (x.nome == "aversao" && y.nome == "tristeza"){
                    titulo = "Tristeza/Aversão"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Tristeza-AversaoT")
                } else if x.nome == "raiva" && y.nome == "medo" || (x.nome == "medo" && y.nome == "raiva"){
                    titulo = "Raiva/Medo"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Raiva-MedoT")
                } else if x.nome == "raiva" && y.nome == "aversao" || (x.nome == "aversao" && y.nome == "raiva"){
                    titulo = "Raiva/Aversão"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Raiva-AversaoT")
                } else if x.nome == "medo" && y.nome == "aversao" || (x.nome == "aversao" && y.nome == "medo"){
                    titulo = "Medo/Aversão"
                    celula.imgMemoriaTimeline.image = #imageLiteral(resourceName: "Medo-AversaoT")
                }
            }
        }
        if (memorias[indexPath.row].tem!.count) == 1{
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
        memorias[indexPath.row].titulo = titulo
        
        celula.emocaoMemoriaTimeline.text = titulo
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        return celula
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
                let triggerDiario = Calendar.current.dateComponents([.day,.hour,.minute,.second], from: date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDiario, repeats: false)
    
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

