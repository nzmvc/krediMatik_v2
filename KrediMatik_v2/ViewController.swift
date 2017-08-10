//
//  ViewController.swift
//  KrediMatik_v2
//
//  Created by MacBook on 27/07/17.
//  Copyright © 2017 MacBook. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class ViewController: UIViewController , GADBannerViewDelegate ,UIPickerViewDataSource,UIPickerViewDelegate{
    
    
    //************************  Degişken Tanımları
    //*************************************************************
    
    let red = UIImage(named: "btn_red.png") as UIImage?
    let blue = UIImage(named: "btn_blue.png") as UIImage?
    let redLarge = UIImage(named: "btn_buyuk_red.png") as UIImage?
    let blueLarge = UIImage(named: "btn_buyuk_blue.png") as UIImage?
    var ref: DatabaseReference!
    let formatter = NumberFormatter()
    var krediTipi = 1  // default 1=taşıt , 2=ev , 3=ihtiyac
    var bireyselTicari = 1 // default 1=bireysel, 2=ticari
    var pmt = Double()
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var scale = 1
    var bankaFaizOran = [[String]]()
    var evOran : Double = 0.0
    var tasitOran : Double = 0.0
    var ihtiyacOran : Double = 0.0
    
    
    
    //************************  Outlet Tanımları
    //*************************************************************
    
    @IBOutlet weak var tasitBtn: UIButton!
    @IBOutlet weak var ihtiyacBtn: UIButton!
    @IBOutlet weak var evBtn: UIButton!
    @IBOutlet weak var bireysel: UIButton!
    @IBOutlet weak var ticari: UIButton!
    @IBOutlet weak var aylikOdeme: UILabel!
    @IBOutlet weak var faizFarki: UILabel!
    @IBOutlet weak var geriOdeme: UILabel!
    @IBOutlet weak var tutar: UITextField!
    @IBOutlet weak var vade: UITextField!
    @IBOutlet weak var oran: UITextField!
    @IBOutlet weak var reklamView: UIView!
    @IBOutlet weak var oranListe: UIPickerView!
    
    //************************  IB Function Tanımları
    //*************************************************************
    
    @IBAction func tutarTiklandi(_ sender: Any) {
        
        tutar.text = ""
    }

    @IBAction func topButtonPressed(_ sender: AnyObject) {
        
        krediTipi = sender.tag
        switch sender.tag {
        case 1: changeTopButtonColor(image1: red!, image2: blue!, image3: blue!)
        case 2: changeTopButtonColor(image1: blue!, image2: red!, image3: blue!)
        case 3: changeTopButtonColor(image1: blue!, image2: blue!, image3: red!)
        default : break
        }
        print(krediTipi)
        hesapla()
    }

    @IBAction func midButtonPressed(_ sender: AnyObject) {
        
        switch sender.tag {
        case 1: changeMidButtonColor(image1: redLarge!, image2: blueLarge!)
        case 2: changeMidButtonColor(image1: blueLarge!, image2: redLarge!)
        default:break
        }
        
        bireyselTicari = sender.tag
        print(bireyselTicari)
        hesapla()
    }

    @IBAction func degerDegisimi(_ sender: AnyObject) {
        hesapla()
    }


 
    //*************************************************************
    //*************************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bankaFaizOran.append(["garanti","1.1","1.2","1.3"])
        //bankaFaizOran.append(["ykb","2.1","2.2","2.3"])
        
        oranListe.dataSource = self
        oranListe.delegate = self
        oranListe.isHidden=true
        
        // landscape force
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        
        ref = Database.database().reference()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.locale = Locale(identifier: "en_TR")
     
        //  ??????????????????????
        // TODO banka listesini alarak tüm veriyi çekebilir hale getir.
        // GARANTİ
    

        ref.child("bankalar").child("garanti").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.tasitOran = (value?["tasit"] as? Double)!
            self.evOran = (value?["ev"] as? Double)!
            self.ihtiyacOran = value?["ihtiyac"]  as! Double
            
            self.bankaFaizOran.append(["Garanti",String(self.tasitOran),String(self.evOran),String(self.ihtiyacOran)])
            
            // ...
        }) { (error) in
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            print(error.localizedDescription)
        }
        
        // YKB
        ref.child("bankalar").child("ykb").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.tasitOran = (value?["tasit"] as? Double)!
            self.evOran = (value?["ev"] as? Double)!
            self.ihtiyacOran = value?["ihtiyac"]  as! Double
    
            self.bankaFaizOran.append(["YKB",String(self.tasitOran),String(self.evOran),String(self.ihtiyacOran)])
            
            // ...
        }) { (error) in
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            print(error.localizedDescription)
        }
        
        
        
        //  farklı ekran boyları için kod içinden değişim
        //if view.frame.size.height == 568 {
        // scale = Int(0.8)
        //}
        //tasitButton.contentScaleFactor.
        

        
        // Do any additional setup after loading the view, typically from a nib.
       
        // test için  interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        // geçiş : ca-app-pub-5192781951301527/8388631651
        // banner :ca-app-pub-5192781951301527/7833974179
     
        // test  Ad format	Sample ad unit ID
        //Banner	ca-app-pub-3940256099942544/6300978111
        //Interstitial	ca-app-pub-3940256099942544/1033173712
        //  https://developers.google.com/admob/ios/banner
        
        // interstitial
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-5192781951301527/8388631651")
        let request = GADRequest()
        interstitial.load(request)
        
        // reklam banner
        
        print ("FFFFFFFFFFFFFFFFFFFF")
        print (view.frame.size.width)
        if view.frame.size.width == 320 {
            bannerView = GADBannerView(adSize: kGADAdSizeBanner)
            reklamView.frame = CGRect(x: 0, y: 518, width: 320, height: 50)
            //reklamView.frame.size.height = 50
        } else {  // 320
            bannerView = GADBannerView(adSize: kGADAdSizeFullBanner)
            
            
        }
        
        
        //self.view.addSubview(bannerView)
        self.reklamView.addSubview(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        bannerView.rootViewController = self
        //bannerView.delegate = self
        bannerView.load(GADRequest())
 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //*************************** FONKSIYONLAR
    //*************************************************************
    
    
    // --------------------------------------------------------------------------------
    // --------------------------------------------------------------------------------
    // excel formul hesaplamaları için internetten bulduğum class
    // --------------------------------------------------------------------------------
    class ExcelFormulas {
        class func pmt(_ rate : Double, nper : Double, pv : Double, fv : Double = 0, type : Double = 0) -> Double {
            return ((-pv * pvif(rate, nper: nper) - fv) / ((1.0 + rate * type) * fvifa(rate, nper: nper)))
        }
        
        class func pow1pm1(_ x : Double, y : Double) -> Double {
            return (x <= -1) ? pow((1 + x), y) - 1 : exp(y * log(1.0 + x)) - 1
        }
        
        class func pow1p(_ x : Double, y : Double) -> Double {
            return (abs(x) > 0.5) ? pow((1 + x), y) : exp(y * log(1.0 + x))
        }
        
        class func pvif(_ rate : Double, nper : Double) -> Double {
            return pow1p(rate, y: nper)
        }
        
        class func fvifa(_ rate : Double, nper : Double) -> Double {
            return (rate == 0) ? nper : pow1pm1(rate, y: nper) / rate
        }
        
    }
    // --------------------------------------------------------------------------------
    // --------------------------------------------------------------------------------
    // --------------- hata ekran fonksiyonu ------------------------------------------
    // --------------------------------------------------------------------------------
    func errScreen(_ str : String){
        
        let alert = UIAlertController(title: "Error", message: str, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    // landscape force
    override var shouldAutorotate : Bool {
        return false
    }
    ///////////// text field içinden cıkarkan keyboard un yok olması için //////
    ////////////////////////////////////////////////////////////////////////////
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn (_ textField: UITextField!) -> Bool{
        /*
        KrediTutari.resignFirstResponder()
        vade.resignFirstResponder()
        oran.resignFirstResponder()
        oranListe.resignFirstResponder()
        pickerAy.resignFirstResponder()
        */
        return true
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////
    func changeTopButtonColor (image1: UIImage, image2: UIImage, image3: UIImage){
        tasitBtn.setBackgroundImage(image1, for: UIControlState.normal)
        evBtn.setBackgroundImage(image2, for: UIControlState.normal)
        ihtiyacBtn.setBackgroundImage(image3, for: UIControlState.normal)
    }
    func changeMidButtonColor (image1: UIImage, image2: UIImage){
        bireysel.setBackgroundImage(image1, for: UIControlState.normal)
        ticari.setBackgroundImage(image2, for: UIControlState.normal)
    }
    func reklamGoster() {
        if self.interstitial.isReady {
            self.interstitial.present(fromRootViewController: self)
        }
    }

    func hesapla () {
        
        var krediT = 0
        var xNSNumber2 : NSNumber
        
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.locale = Locale(identifier: "en_TR")
        
        if tutar.text != "" {
            krediT      = Int(tutar.text!.replacingOccurrences(of: ".", with: ""))!
            let numberString2 = krediT
            xNSNumber2  = numberString2 as NSNumber
            tutar.text       = String( validatingUTF8: formatter.string(from: xNSNumber2)!)
            
        }

        
        if tutar.text != "" && vade.text != "" && oran.text != "" {
            krediT      = Int(tutar.text!.replacingOccurrences(of: ".", with: ""))! //
            let vadeSayisi  = Int (vade.text!)
            let oranDegeri  = Double (oran.text!)
            
            if krediT < 9999999 && vadeSayisi != nil && oranDegeri != nil && oranDegeri != 0   && krediT != 0 && vadeSayisi! != 0 {
                
                if ( krediTipi != 2 ) { // taşıt ve ihtiyaç için hesaplama
                    if ( bireyselTicari == 1 ) {
                        // bireysel
                        pmt = ExcelFormulas.pmt( Double(oran.text!)! * 0.012, nper: Double(vade.text!)!, pv: Double(krediT))
                        
                    } else {
                        // ticari
                        pmt = ExcelFormulas.pmt( Double(oran.text!)! * 0.0105, nper: Double(vade.text!)!, pv: Double(krediT))
                    }
                } else { // mortgage için hesaplama
                    pmt = ExcelFormulas.pmt( Double(oran.text!)! * 0.001, nper: Double(vade.text!)!, pv: Double(krediT))
                }
                
                
              
                // AYLIK ODEME Format
                var numberString = round(pmt * (-1))
                var xNSNumber  = numberString as NSNumber
                aylikOdeme.text = "   " + String( validatingUTF8: formatter.string(from: xNSNumber)!)! + " TL"
                
                
                // GERI ODEME Format
                numberString = round(pmt * (-1) * Double(vade.text!)!)
                xNSNumber = numberString as NSNumber
                geriOdeme.text = "   " + String( validatingUTF8: formatter.string(from: xNSNumber)!)! + " TL"
              
                //  FAIZ FARKI format
                numberString = round(pmt * (-1) * Double(vade.text!)! - Double(krediT))
                xNSNumber  = numberString as NSNumber
                faizFarki.text = "   " + String( validatingUTF8: formatter.string(from: xNSNumber)!)! + " TL"
               
                
            }
        }
    }
    
    
    // ************************************** picker view settings
    // ***************************************************************
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1        // yan yana kac secim yapılacağını belirtir. component ile ıd mantığıyla kullanılır
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        return bankaFaizOran.count
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
            if krediTipi == 1 {     // tasıt kredisinde vade max 60 ay oldugundan
                
                if bankaFaizOran.count > 0 {
                    if bankaFaizOran[row][krediTipi] != "0" {
                        return bankaFaizOran[row][0] + " " + bankaFaizOran[row][krediTipi] + " %"
                    }
                }
                
                return ""
                
            } else {                //
                
                if  bankaFaizOran.count > 0 {
                    if bankaFaizOran[row][krediTipi] != "0" {
                        return bankaFaizOran[row][0] + " " + bankaFaizOran[row][krediTipi] + " %"
                    }
                }
                
                return ""
                
            }
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if bankaFaizOran.count > 0 {
            
            oran.text = bankaFaizOran[row][krediTipi]
            oranListe.isHidden=true
            //otomatikHesapla(1 as AnyObject)
            hesapla()
        }
        
        if bankaFaizOran.count == 0 {
            
            oran.text = "1"
            oranListe.isHidden=true
        }
        
    }
    
    
    // --------------------------------------------------------------------------------
    // --------------------------------------------------------------------------------
    // oran alanına dokunduğunda picker yavaşça belirir
    // --------------------------------------------------------------------------------
    @IBAction func oranTouched(_ sender: AnyObject) {
        oran.text=""
        self.oranListe.alpha = 0
        self.oranListe.reloadAllComponents()
        
        if bankaFaizOran.count > 0 {
            oranListe.isHidden = false
            
            UIView.animate(withDuration: 0.5, animations : { () -> Void in
                self.oranListe.alpha = 1
            })
        }
        if bankaFaizOran.count == 0 {
            errScreen("Hata : Banka faiz oranları çekilemedi lütfen elle giriş yapınız")
            oran.text="1.01"
        }
    }
    //*******************************
    
}

