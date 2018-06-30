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

    var app = CardTrade_AppConfing()
  
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtCoin: UITextField!
    @IBOutlet weak var txtRating: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    let myProfile = profile()
    var Status = ""
    var type = ""
    var idUser = ""
    
    
    @IBOutlet weak var UpdatepoUpView: UIView!
    @IBOutlet weak var PopupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = UserDefaults.standard
        let userId = userDefaults.integer(forKey: "UserId")
        print(userId)
        Alamofire.request(app.API_HOST+"/Profiles/" + String(userId)).responseJSON { response in
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
                self.Status = sJson["Status"].stringValue
                self.type = sJson["Type"].stringValue
                self.idUser = sJson["IdUser"].stringValue
                
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
        
        UpdatepoUpView.layer.cornerRadius = 10
        UpdatepoUpView.layer.masksToBounds = true
        
    }
    
    @IBOutlet weak var centerPopup: NSLayoutConstraint!
    @IBAction func cancelLogout(_ sender: Any) {
        PopupView.isHidden = true
        
        
    }
    
    @IBAction func cancelUpdateprofile(_ sender: Any) {
        UpdatepoUpView.isHidden = true
    }
    @IBAction func ShowPopup(_ sender: Any) {
        PopupView.isHidden = false
        
       
    }
    
    @IBAction func UpdateProfilePressed(_ sender: Any) {
        
        UpdatepoUpView.isHidden = false
    }
    
    
    @IBAction func btnUpdateInformation(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        let userId = userDefaults.integer(forKey: "UserId")
        
        let parameters : Parameters = [
            "Id" : userId,
            "Name": txtName.text!,
            "Type": type,
            "Status": Status,
            "Email": txtEmail.text!,
            "Phone": txtPhone.text!,
            "Age": txtAge.text!,
            "Sex": txtGender.text!,
            "Coins": txtCoin.text!,
            "Rating": txtRating.text!,
            "Address": txtAddress.text!,            
            "IdUser": idUser
        ]
        print(parameters)
        Alamofire.request(app.API_HOST+"/Profiles/" + String(userId) , method: .put, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            if(response.response?.statusCode == 200){
                let alert = UIAlertController(title: "SUCCESS", message: "Tu actualizacion ha sido exitosa", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                    (action: UIAlertAction!) in
                   // self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "Fail!", message: "Ups Algo salió mal, intenta denuevo", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        UpdatepoUpView.isHidden = true
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
