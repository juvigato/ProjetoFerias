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
import LocalAuthentication

class TimelineMemoriasController: UITableViewController{
    
    public var memorias:[Memoria] = []
    
    var context:NSManagedObjectContext?
    
    var semMemoriaImg:UIImageView = UIImageView(image: UIImage(named: "semMemoriaImg"))
    
    var imagemBackground:UIImage = UIImage(named: "background.jpg") ?? UIImage()
    
    /**
    *Carregar  todas características necessárias da tela*
     - Parameters: Nada
     - Returns: Nada
     */
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
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        detectarPrimeiroLançamento()
        carregarMemorias()
        notificacao()
    }
    
    /**
    *Detectar se é ou não o primeiro lançamento do aplicativo*
     - Parameters: Nada
     - Returns: Nada
     */
    func detectarPrimeiroLançamento() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
//            launchAuth()
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set("Original", forKey: "tema")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        launchAuth()
    }
    
    func launchAuth() {
//        view.isHidden = true
        print("hello there!.. You have clicked the touch ID")
        
        let myContext = LAContext()
        let myLocalizedReasonString = "Biometric Authntication testing !! "
        
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    
                    DispatchQueue.main.async {
                        if success {
                            // User authenticated successfully, take appropriate action
                            print("Awesome!!... User authenticated successfully")
                        } else {
                            // User did not authenticate successfully, look at error and take appropriate action
                            print("Sorry!!... User did not authenticate successfully")
                        }
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
                print("Sorry!!.. Could not evaluate policy.")
            }
        } else {
            // Fallback on earlier versions
            print("Ooops!!.. This feature is not supported.")
        }
    }
    
    /**
    *Carregar todas as características da tela que irá aparecer*
     - Parameters:
      - animated: valor booleano
     - Returns: Nada
     */
    override func viewWillAppear(_ animated: Bool) {
//        no()
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
    
    
    /**
    *Carregar todas memórias já existentem*
     - Parameters: Nada
     - Returns: Nada
     */
    func carregarMemorias(){
        do{
            memorias = try context!.fetch(Memoria.fetchRequest())
        } catch {
            print("Falha na Timeline")
            return
        }
    }
    
    /**
    *Checar número de linhas em uma tableview*
     - Parameters:
      - tableView: uma tableView que irá aparecer na tela do tipo UITableView
      - numberOfRowsInSection: número de linhas em uma seção do tipo Inteiro
     - Returns: um número Inteiro
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memorias.count
    }
    
    /**
    *Possibilitar edição da tableview*
     - Parameters:
      - tableView: tableView carregada na tela do tipo UITableView
      - editingStyle: tipo de ocorrência na célula da tableView
      - indexPath: o index da célula da tableView
     - Returns: Nada
     */
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context?.delete(memorias[indexPath.row])
            memorias.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            //adicionar uma imagem se não houver memorias
            if memorias.count == 0 {
                semMemoriaImg.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
                self.view.addSubview(semMemoriaImg)
                semMemoriaImg.center.x = self.view.center.x
                semMemoriaImg.center.y = self.view.center.y - 80
            }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
    }

    /**
    *Método que permite a ação de saída da tela*
     - Parameters:
      - sender: segue do storyboard
     - Returns: Nada
     */
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
    
    /**
    *Formatar data*
     - Parameters:
      - date: data em formato Date
     - Returns:data em formato de String
     */
    func formatarData(date:Date) -> String{
        let formatter = DateFormatter()
//        formatter.dateFormat = "dd.MM.yyyy"
        formatter.dateFormat = "dd/MM/yyyy"
//        formatter.dateFormat = "EEEE, MMM d, yyyy"
        let dataAtual = formatter.string(from: date)
        return dataAtual
    }
    
    /**
    *Carregar células da tableView e seus respectivos itens*
     - Parameters:
      - tableView: tableView que aparecerá na tela
      - indexPath: index da célula da tableView
     - Returns: célula da tableView recebida
     */
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
            celula.imgTarraxinhaEsq.image = UIImage(named: "tarraxinhaOriginal")
            celula.imgTarraxinhaDir.image = UIImage(named: "tarraxinhaOriginal")
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
            celula.imgTarraxinhaEsq.image = UIImage(named: "tarraxinhaCinza")
            celula.imgTarraxinhaDir.image = UIImage(named: "tarraxinhaCinza")
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
                    } else if x.nome == "tristeza" && y.nome == "raiva" || (x.nome == "raiva" && y.nome == "tristeza"){
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
        } else if UserDefaults.standard.string(forKey: "tema") == "Cores pastéis" {
            celula.imgTarraxinhaEsq.image = UIImage(named: "tarraxinhaPastel")
            celula.imgTarraxinhaDir.image = UIImage(named: "tarraxinhaPastel")
            if (memorias[indexPath.row].tem!.count) > 1 {
                let y:Sentimento = memorias[indexPath.row].tem![1] as! Sentimento
                if (x.nome != nil || y.nome != nil){
                    if (x.nome == "alegria" && y.nome == "tristeza") || (x.nome == "tristeza" && y.nome == "alegria"){
                        titulo = "alegriaTristezaPastel"
                    } else if (x.nome == "alegria" && y.nome == "raiva") || (x.nome == "raiva" && y.nome == "alegria") {
                        titulo = "alegriaRaivaPastel"
                    } else if (x.nome == "alegria" && y.nome == "medo") || (x.nome == "medo" && y.nome == "alegria"){
                        titulo = "alegriaMedoPastel"
                    } else if x.nome == "alegria" && y.nome == "aversao" || (x.nome == "aversao" && y.nome == "alegria"){
                        titulo = "alegriaAversaoPastel"
                    } else if x.nome == "tristeza" && y.nome == "raiva" || (x.nome == "raiva" && y.nome == "tristeza"){
                        titulo = "tristezaRaivaPastel"
                    } else if x.nome == "tristeza" && y.nome == "medo" || (x.nome == "medo" && y.nome == "tristeza"){
                        titulo = "tristezaMedoPastel"
                    } else if x.nome == "tristeza" && y.nome == "aversao" || (x.nome == "aversao" && y.nome == "tristeza"){
                        titulo = "tristezaAversaoPastel"
                    } else if x.nome == "raiva" && y.nome == "medo" || (x.nome == "medo" && y.nome == "raiva"){
                        titulo = "raivaMedoPastel"
                    } else if x.nome == "raiva" && y.nome == "aversao" || (x.nome == "aversao" && y.nome == "raiva"){
                        titulo = "raivaAversaoPastel"
                    } else if x.nome == "medo" && y.nome == "aversao" || (x.nome == "aversao" && y.nome == "medo"){
                        titulo = "medoAversaoPastel"
                    }
                }
            }
            if (memorias[indexPath.row].tem!.count) == 1{
                if x.nome == "alegria" {
                    titulo = "alegriaPastel"
                } else if x.nome == "tristeza" {
                    titulo = "tristezaPastel"
                } else if x.nome == "raiva" {
                    titulo = "raivaPastel"
                } else if x.nome == "medo" {
                    titulo = "medoPastel"
                } else if x.nome == "aversao" {
                    titulo = "aversaoPastel"
                }
            }
        }
        memorias[indexPath.row].titulo = titulo
        celula.imgMemoriaTimeline.image = UIImage(named: titulo)
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        return celula
    }
    
    /**
    *Preparar a tela que virá a seguir*
     - Parameters:
      - segue: segue do storyboard
      - sender: algum gatilho do storyboard
     - Returns: Nada
     */
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
    
    /**
    *Criar notificações e pedir autorização*
     - Parameters: Nada
     - Returns: Nada
     */
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
