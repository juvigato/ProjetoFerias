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
    
    var semMemoriaImg:UIImageView = UIImageView(image: UIImage(named: "semMemoriaImg"))
    
    var imagemBackground:UIImage = UIImage(named: "background.jpg") ?? UIImage()
        
//    var imagemBackgroundCinza:UIImage = UIImage(named: "backgroundCinza.png") ?? UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 250
        self.view.backgroundColor = UIColor(patternImage: imagemBackground)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3450980392, green: 0.4901960784, blue: 0.9019607843, alpha: 1)
        self.tableView.separatorStyle = .none
//        UserDefaults.standard.set("Original", forKey: "tema")
        detectarPrimeiroLançamento()
        carregarMemorias()
        notificacao()
        
    }
    
    func detectarPrimeiroLançamento() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set("Original", forKey: "tema")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        carregarMemorias()
        
        if memorias.count == 0 {
            semMemoriaImg.frame = CGRect(x: 0, y: 0, width: 220, height: 220)
            self.view.addSubview(semMemoriaImg)
            semMemoriaImg.center.x = self.view.center.x
            semMemoriaImg.center.y = self.view.center.y - 80
        } else {
            semMemoriaImg.removeFromSuperview()
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
                if senderAdd.novaMemoria != nil{
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
//        formatter.dateFormat = "dd.MM.yyyy"
        formatter.dateFormat = "dd/MM/yyyy"
//        formatter.dateFormat = "EEEE, MMM d, yyyy"
        let dataAtual = formatter.string(from: date)
        return dataAtual
    }
    
    //carregar as células
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath) as! MemoriaTableViewCelula

        celula.imgMemoriaTimeline.image = UIImage(named: "vazio")
        celula.layer.backgroundColor = UIColor.clear.cgColor
        
//        if memorias[indexPath.row].situacao == nil{
//            celula.situacaoMemoriaTimeline.text = "Adicione mais detalhes..."
//        } else{
//            celula.situacaoMemoriaTimeline.text = memorias[indexPath.row].situacao
//        }
        
        if memorias[indexPath.row].data != nil{
            celula.dataText.text = formatarData(date: memorias[indexPath.row].data as! Date)
        } else{
            celula.dataText.text = "Sem data"
        }
        
        var titulo:String = ""
        
        let x:Sentimento = memorias[indexPath.row].tem![0] as! Sentimento
        
        if UserDefaults.standard.string(forKey: "tema") == "Original" {
            if (memorias[indexPath.row].tem!.count) > 1 {
                let y:Sentimento = memorias[indexPath.row].tem![1] as! Sentimento
                if (x.nome != nil || y.nome != nil){
                    if (x.nome == "alegria" && y.nome == "tristeza") || (x.nome == "tristeza" && y.nome == "alegria"){
                        titulo = "alegriaTristeza"
                    } else if (x.nome == "alegria" && y.nome == "raiva") || (x.nome == "raiva" && y.nome == "alegria") {
                        titulo = "alegriaRaiva"
                    } else if (x.nome == "alegria" && y.nome == "medo") || (x.nome == "medo" && y.nome == "alegria"){
                        titulo = "alegriaMedo"
                    } else if x.nome == "alegria" && y.nome == "aversao" || (x.nome == "aversao" && y.nome == "alegria"){
                        titulo = "alegriaAversao"
                    } else if x.nome == "tristeza" && y.nome == "raiva" || (x.nome == "raiva" && y.nome == "tristeza"){
                        titulo = "tristezaRaiva"
                    } else if x.nome == "tristeza" && y.nome == "medo" || (x.nome == "medo" && y.nome == "tristeza"){
                        titulo = "tristezaMedo"
                    } else if x.nome == "tristeza" && y.nome == "aversao" || (x.nome == "aversao" && y.nome == "tristeza"){
                        titulo = "tristezaAversao"
                    } else if x.nome == "raiva" && y.nome == "medo" || (x.nome == "medo" && y.nome == "raiva"){
                        titulo = "raivaMedo"
                    } else if x.nome == "raiva" && y.nome == "aversao" || (x.nome == "aversao" && y.nome == "raiva"){
                        titulo = "raivaAversao"
                    } else if x.nome == "medo" && y.nome == "aversao" || (x.nome == "aversao" && y.nome == "medo"){
                        titulo = "medoAversao"
                    }
                }
            }
            if (memorias[indexPath.row].tem!.count) == 1{
                if x.nome == "alegria" {
                    titulo = "alegria"
                } else if x.nome == "tristeza" {
                    titulo = "tristeza"
                } else if x.nome == "raiva" {
                    titulo = "raiva"
                } else if x.nome == "medo" {
                    titulo = "medo"
                } else if x.nome == "aversao" {
                    titulo = "aversao"
                }

            }
        } else if UserDefaults.standard.string(forKey: "tema") == "Escala de cinza"{
            
            if (memorias[indexPath.row].tem!.count) > 1 {
                let y:Sentimento = memorias[indexPath.row].tem![1] as! Sentimento
                if (x.nome != nil || y.nome != nil){
                    if (x.nome == "alegria" && y.nome == "tristeza") || (x.nome == "tristeza" && y.nome == "alegria"){
                        titulo = "alegriaTristezaCinza"
                    } else if (x.nome == "alegria" && y.nome == "raiva") || (x.nome == "raiva" && y.nome == "alegria") {
                        titulo = "alegriaRaivaCinza"
                    } else if (x.nome == "alegria" && y.nome == "medo") || (x.nome == "medo" && y.nome == "alegria"){
                        titulo = "alegriaMedoCinza"
                    } else if x.nome == "alegria" && y.nome == "aversao" || (x.nome == "aversao" && y.nome == "alegria"){
                        titulo = "alegriaAversaoCinza"
                    } else if x.nome == "tristeza" && y.nome == "raiva" || (x.nome == "raiva" && y.nome == "tristezaCinza"){
                        titulo = "tristezaRaivaCinza"
                    } else if x.nome == "tristeza" && y.nome == "medo" || (x.nome == "medo" && y.nome == "tristeza"){
                        titulo = "tristezaMedoCinza"
                    } else if x.nome == "tristeza" && y.nome == "aversao" || (x.nome == "aversao" && y.nome == "tristeza"){
                        titulo = "tristezaAversaoCinza"
                    } else if x.nome == "raiva" && y.nome == "medo" || (x.nome == "medo" && y.nome == "raiva"){
                        titulo = "raivaMedoCinza"
                    } else if x.nome == "raiva" && y.nome == "aversao" || (x.nome == "aversao" && y.nome == "raiva"){
                        titulo = "raivaAversaoCinza"
                    } else if x.nome == "medo" && y.nome == "aversao" || (x.nome == "aversao" && y.nome == "medo"){
                        titulo = "medoAversaoCinza"
                    }
                }
            }
            if (memorias[indexPath.row].tem!.count) == 1{
                if x.nome == "alegria" {
                    titulo = "alegriaCinza"
                } else if x.nome == "tristeza" {
                    titulo = "tristezaCinza"
                } else if x.nome == "raiva" {
                    titulo = "raivaCinza"
                } else if x.nome == "medo" {
                    titulo = "medoCinza"
                } else if x.nome == "aversao" {
                    titulo = "aversaoCinza"
                }
            }
        }
        
        memorias[indexPath.row].titulo = titulo
        celula.imgMemoriaTimeline.image = UIImage(named: titulo)
//        celula.emocaoMemoriaTimeline.text = titulo
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        return celula
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let memoriaTVC = segue.destination as? MemoriaTableViewController{
            if segue.identifier == "detalhesMemoria"{
                if let indexPath = tableView.indexPathForSelectedRow{
                    let memoriaTemp = memorias[indexPath.row]
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
    
                let date = Date(timeIntervalSinceNow: 3600)
                let triggerDiario = Calendar.current.dateComponents([.day,.hour,.minute,.second], from: date)
//                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDiario, repeats: false)
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//                let request = UNNotificationRequest(identifier: "diario", content: content, trigger: trigger)
                let request = UNNotificationRequest(identifier: "5seconds", content: content, trigger: trigger)
                
                let center = UNUserNotificationCenter.current()
                    center.add(request) { (error: Error?) in
                    if let error = error{
                        print(error.localizedDescription)
                    }
                }
                
                UserDefaults.standard.setValue("on", forKey: "notificacoes")
                
            } else {
                print("Permissão negada - notificações desativadas")
                UserDefaults.standard.setValue("off", forKey: "notificacoes")
            }
        }
    }
}

