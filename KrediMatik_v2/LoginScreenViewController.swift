//
//  LoginScreenViewController.swift
//  KrediMatik_v2
//
//  Created by MacBook on 16/08/17.
//  Copyright © 2017 MacBook. All rights reserved.
//

import UIKit
import Firebase


class LoginScreenViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBAction func Login(_ sender: Any) {
        
        if email.text != nil && password.text != nil {
        
            Auth.auth().signIn(withEmail: email.text!, password: password.text!, completion: {(user,error) in
                
                if error != nil {
                    print(error!)
                
                } else {
                
                    // login basarılı
                    let faizGuncelleStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    
                    let faizGuncelleVC = faizGuncelleStoryboard.instantiateViewController(withIdentifier: "faizGuncelleVC")
                    self.present(faizGuncelleVC, animated: true, completion: nil)
                    
                }
            
            
            })
            
        } else {
        
            print("kullanıcı adı ve şifre boş bırakılamaz")
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
