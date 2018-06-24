//
//  ProfileViewController.swift
//  CardTrade
//
//  Created by Bridge xd on 23/06/18.
//  Copyright © 2018 xer0. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProfileViewController: UIViewController {

  
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtCoin: UITextField!
    @IBOutlet weak var txtRating: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    let myProfile = profile()
    
    @IBOutlet weak var PopupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = UserDefaults.standard
        let userId = userDefaults.integer(forKey: "UserId")
        print(userId)
        Alamofire.request("http://192.168.1.2:45455/api/Profiles/" + String(userId)).responseJSON { response in
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                //Read json
                let sJson = JSON(json)
                print(sJson["Name"].stringValue)
                self.myProfile.Name = sJson["Name"].stringValue
                self.myProfile.Email = sJson["Email"].stringValue
                self.myProfile.Phone = sJson["Phone"].stringValue
                self.myProfile.Age = sJson["Age"].stringValue
                self.myProfile.Sex = sJson["Sex"].stringValue
                self.myProfile.Coins = sJson["Coins"].intValue
                self.myProfile.Rating = sJson["Rating"].doubleValue
                self.myProfile.Address = sJson["Address"].stringValue
                
                self.txtName.text =  self.myProfile.Name
                self.txtEmail.text =  self.myProfile.Email
                self.txtPhone.text = self.myProfile.Phone
                self.txtAge.text = self.myProfile.Age
                self.txtGender.text = self.myProfile.Sex
                self.txtCoin.text = String(self.myProfile.Coins)
                self.txtRating.text = String(self.myProfile.Rating)
                self.txtAddress.text = self.myProfile.Address
            }
        }
        PopupView.layer.cornerRadius = 10
        PopupView.layer.masksToBounds = true
    }
    
    @IBOutlet weak var centerPopup: NSLayoutConstraint!
    @IBAction func cancelLogout(_ sender: Any) {
        PopupView.isHidden = true
        
        
    }
    
    @IBAction func ShowPopup(_ sender: Any) {
        PopupView.isHidden = false
        
       
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
