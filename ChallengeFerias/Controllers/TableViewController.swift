//
//  ViewController.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 12/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            performSegue(withIdentifier: "showSituacao", sender: nil)

        } else if indexPath.row == 2{
            performSegue(withIdentifier: "showPensamentos", sender: nil)
        } else if indexPath.row == 3{
            performSegue(withIdentifier: "showAtitude", sender: nil)
        } else if indexPath.row == 4{
            performSegue(withIdentifier: "showResultado", sender: nil)
        }
    }

}



//You can use the UITableView delegate like this:
//
//func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//
//    // row 1 corresponds to the second cell.
//    if indexPath.row == 1 {
//        performSegueWithIdentifier("MySegueID", sender: self)
//    }
//}

