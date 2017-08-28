                                                                     //
//  BankaEkleViewController.swift
//  KrediMatik_v2
//
//  Created by MacBook on 27/08/17.
//  Copyright © 2017 MacBook. All rights reserved.
//
import Firebase
import UIKit

class BankaEkleViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var bankaAdi: UITextField!
    @IBOutlet weak var tasitOran: UITextField!
    @IBOutlet weak var ihtiyacOran: UITextField!
    @IBOutlet weak var evOran: UITextField!
    
    @IBAction func ekleButton(_ sender: Any) {
        
        let ref = Database.database().reference()
        if ( bankaAdi.text != nil && tasitOran.text != nil && ihtiyacOran.text != nil && evOran.text != nil ){
        
            //TODO:
            // image yüklenecek yada tüm bankaların iconları program ile birlikte yüklenecek
            // bankalar seçimlik de yapılabilir.
            
            ref.child("bankalar").child(bankaAdi.text!).child("ev").setValue(Double(evOran.text!))
            ref.child("bankalar").child(bankaAdi.text!).child("ihtiyac").setValue(Double(ihtiyacOran.text!))
            ref.child("bankalar").child(bankaAdi.text!).child("tasit").setValue(Double(tasitOran.text!))
            ref.child("bankalar").child(bankaAdi.text!).child("name").setValue(bankaAdi.text)
            
        } else {
        
            print ("Alanlar boş bırakılamaz")
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
