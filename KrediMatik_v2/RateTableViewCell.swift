//
//  RateTableViewCell.swift
//  KrediMatik_v2
//
//  Created by MacBook on 16/08/17.
//  Copyright © 2017 MacBook. All rights reserved.
//

import UIKit

class RateTableViewCell: UITableViewCell {

    @IBOutlet weak var bankaAdi: UITextField!
    @IBOutlet weak var evOran: UITextField!
    @IBOutlet weak var arabaOran: UITextField!
    @IBOutlet weak var ihtiyacOran: UITextField!
    
    
    
    @IBAction func guncelle(_ sender: Any) {
        
        
    }
    
    @IBAction func sil(_ sender: Any) {
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
