//
//  KarsilastirViewController.swift
//  KrediMatik_v2
//
//  Created by MacBook on 12/08/17.
//  Copyright © 2017 MacBook. All rights reserved.
//

import UIKit
import MessageUI

class KarsilastirViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate {

    var compareArr = [[String]]()
    var garanti = UIImage(named: "garanti_icon.png")
    var ykb = UIImage(named: "ykb_icon.png")
    var finans = UIImage(named: "finans_icon.jpeg")
    var ziraat = UIImage(named: "ziraat_icon.jpeg")
    var isbank = UIImage(named: "ykb_icon.png")
    var krediMatikIcon = UIImage(named: "KrediMatik.png")
    
    @IBOutlet weak var compareTable: UITableView!
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
    
    private func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: IndexPath){
        
        if editingStyle == UITableViewCellEditingStyle.delete {    // tabloda yapılan edit işlemini kontrol eder
            
            compareArr.remove(at: indexPath.row)
            compareTable.reloadData()     //   silme işi sonrasında tabloyu yeniden yuklemeliyiz
        }
    }
    
    //**************************  MAIL AYARLARI
    //**********************************************
    
    @IBAction func sendMail(_ sender: AnyObject) {
        
        if MFMailComposeViewController.canSendMail() {
            
            let messageTitle = "Kredi Karşılaştırma tablosu"
            var messageBody = "<html> <head> <meta charset=\"utf-8\"><title>Untitled Document</title></head><body><h1><strong>Karşılaştırma tablosu</strong></h1>"
            
            messageBody = messageBody + "<table border=\"1\"> <tr><th>Kredi turarı</th> <th>Vade</th> <th>Oran</th> <th>Aylık Odeme</th> <th>Toplam Odeme</th> <th>Faiz Farkı</th> </tr>"
            
            
            // karşılastırma dizisine eklenen veriler html formatında yazılıyor
            
            
            for row in compareArr{
                
                messageBody = messageBody + "<tr><td>" + row[0] + "</td>"
                messageBody = messageBody + "<td>" + row[1] + "</td>"
                messageBody = messageBody + "<td>" + row[2] + "</td>"
                messageBody = messageBody + "<td>" + row[3] + "</td>"
                messageBody = messageBody + "<td>" + row[4] + "</td>"
                messageBody = messageBody + "<td>" + row[5] + "</td></tr>"
                
            }
            messageBody = messageBody + "</table></body></html>"
            
            
            
            let toRecepient = ["nzm.avci@gmail.com"]
            
            let mc:MFMailComposeViewController = MFMailComposeViewController()
            
            mc.mailComposeDelegate = self
            mc.setSubject(messageTitle)
            mc.setMessageBody(messageBody, isHTML: true)
            mc.setToRecipients(toRecepient)
            
            self.present(mc, animated: true, completion: nil)
            
        } else {
            
            print("You have no email account !!!")
            
        }
        
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue :
            print ("Mail Cancelled")
        case MFMailComposeResult.saved.rawValue:
            print("mail saved")
        case MFMailComposeResult.sent.rawValue:
            print("mail sent")
        case MFMailComposeResult.failed.rawValue:
            print ("mail failed")
        default:
            break
            
            
        }
        
    }
    



}
