//
//  TableViewCell.swift
//  KrediMatik_v2
//
//  Created by MacBook on 12/08/17.
//  Copyright © 2017 MacBook. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var tutar: UILabel!
    @IBOutlet weak var vade: UILabel!
    @IBOutlet weak var oran: UILabel!
    @IBOutlet weak var geriOdeme: UILabel!
    @IBOutlet weak var aylikOdeme: UILabel!
    @IBOutlet weak var faizFarki: UILabel!
    @IBOutlet weak var bankIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
