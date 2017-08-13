//
//  KarsilastirViewController.swift
//  KrediMatik_v2
//
//  Created by MacBook on 12/08/17.
//  Copyright © 2017 MacBook. All rights reserved.
//

import UIKit

class KarsilastirViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var compareArr = [[String]]()
    var garanti = UIImage(named: "garanti_icon.png")
    var ykb = UIImage(named: "ykb_icon.png")
    var finans = UIImage(named: "finans_icon.jpeg")
    var ziraat = UIImage(named: "ziraat_icon.jpeg")
    var isbank = UIImage(named: "ykb_icon.png")
    var krediMatikIcon = UIImage(named: "KrediMatik.png")
    
    @IBOutlet weak var label: UILabel!
    
    
    // landscape force
    override var shouldAutorotate : Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // landscape force
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return compareArr.count
    
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
        
        cell.tutar.text = compareArr[indexPath.row][0]
        cell.vade.text = compareArr[indexPath.row][1]
        cell.oran.text = compareArr[indexPath.row][2]
        cell.aylikOdeme.text = compareArr[indexPath.row][3]
        cell.faizFarki.text = compareArr[indexPath.row][4]
        cell.geriOdeme.text = compareArr[indexPath.row][5]
        
        print("banka" + compareArr[indexPath.row][6])
        
        switch compareArr[indexPath.row][6] {
        case "Garanti":
            cell.bankIcon.image = garanti
        case "YKB":
            cell.bankIcon.image = ykb
        case "Finans":
            cell.bankIcon.image = finans
        case "Akbank":
            cell.bankIcon.image = ykb
        case "ING":
            cell.bankIcon.image = ykb
        case "Isbank":
            cell.bankIcon.image = ykb
        case "Ziraat":
            cell.bankIcon.image = ziraat
        default:
            cell.bankIcon.image = krediMatikIcon
        }
        
        return cell
        
        
    }
    
    



}
