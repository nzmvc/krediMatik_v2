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
    
    @IBOutlet weak var label: UILabel!
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
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
        
        cell.tutar.text = compareArr[indexPath.row][0]
        cell.vade.text = compareArr[indexPath.row][1]
        cell.oran.text = compareArr[indexPath.row][2]
        cell.aylikOdeme.text = compareArr[indexPath.row][3]
        cell.faizFarki.text = compareArr[indexPath.row][4]
        cell.geriOdeme.text = compareArr[indexPath.row][5]
        
        return cell
        
        
    }
    
    // landscape force
    override var shouldAutorotate : Bool {
        return false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
