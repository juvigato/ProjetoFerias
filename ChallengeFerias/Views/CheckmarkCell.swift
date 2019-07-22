//
//  CheckMarkCell.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 22/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import UIKit

class CheckMarkCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnCheckMark: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
