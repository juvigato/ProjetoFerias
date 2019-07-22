//
//  ProgressCircleViewController.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 12/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import Foundation
import UIKit

class ProgressCircleViewController:UIViewController{
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.progressCircle?.circleWidth = 30.0
    }
    
    @IBOutlet weak var progressCircle: ProgressCircleView?
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.progressCircle?.setNeedsDisplay()
    }
    
}
