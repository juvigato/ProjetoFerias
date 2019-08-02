//
//  MemoriaTableViewCelula.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 25/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import Foundation
import UIKit

class MemoriaTableViewCelula: UITableViewCell{
    
    @IBOutlet weak var imgMemoriaTimeline: UIImageView!
    
    @IBOutlet weak var emocaoMemoriaTimeline: UILabel!
    
    @IBOutlet weak var situacaoMemoriaTimeline: UILabel!
    
    @IBOutlet weak var dataText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
