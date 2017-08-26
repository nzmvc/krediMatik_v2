//
//  UpdateRateViewController.swift
//  KrediMatik_v2
//
//  Created by MacBook on 16/08/17.
//  Copyright © 2017 MacBook. All rights reserved.
//

import UIKit
import Firebase

class UpdateRateViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var ref : DatabaseReference!
    var bankalar : NSDictionary?
    var bankaAdları = [String]()
    var dataArr = [[String]]()
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var bankaTablo: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref = Database.database().reference()
        ref.child("bankalar").observe(.value, with: {
           
            snapShot in
            
            self.bankalar = snapShot.value as? NSDictionary
            
            print("XXXXXXXXXXXXXXX") ; print("XXXXXXXXXXXXXXX") ; print("XXXXXXXXXXXXXXX")
            print(String(describing: self.bankalar?.count))

            
            for banka in self.bankalar! {
                
                
                let bankaAdi = banka.key
                let bankaDeger = banka.value  as? NSDictionary
                
                if bankaDeger != nil {
                    
                    //burada hata alıyor
                    //print(bankaDeger?["ev"]! as! String)
                    let evO = bankaDeger!["ev"] as! Double
                    let ihtiyacO = bankaDeger!["ihtiyac"] as! Double
                    let tasitO = bankaDeger!["tasit"] as! Double
                    print("ev oran v1:")
                    print(String(describing: evO))
                    self.dataArr.append([bankaAdi as! String,String(evO),String(tasitO),String(ihtiyacO)])
                    
                    self.bankaTablo.insertRows(at: [IndexPath(row: self.dataArr.count-1, section: 0)], with: UITableViewRowAnimation.automatic)
                }
                
                print("dizideki satır sayısı")
                print(self.dataArr)
                
            }
            
            //self.bankaTablo.reloadData()
            
   
            self.loading.stopAnimating()
            
        })
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{

            return self.dataArr.count
        
    }
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        print("cell oluşturuluyor")
        print(self.dataArr.count)
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "myCell2", for: indexPath) as! RateTableViewCell    // cell için tanımlanan class kullanılmalı dikkat !!!!!!
       print(self.dataArr[indexPath.row][0])
        cell2.bankaAdi.text = self.dataArr[indexPath.row][0]
        cell2.evOran.text = self.dataArr[indexPath.row][1]
        cell2.arabaOran.text = self.dataArr[indexPath.row][2]
        cell2.ihtiyacOran.text = self.dataArr[indexPath.row][3]
        
        return cell2
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
