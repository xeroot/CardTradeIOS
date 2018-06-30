//
//  RegisterViewController.swift
//  CardTrade
//
//  Created by xer0 on 29/06/18.
//  Copyright © 2018 xer0. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterViewController: UIViewController {
    var app = CardTrade_AppConfing()

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserLastname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var swcGender: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btCreateOnClick(_ sender: Any) {
        var iduserCreated : Int = 0
        
        // creando user
        let userParams : Parameters = [
            "username":txtUsername.text!,
            "pass":txtPassword.text!
        ]
        Alamofire.request(app.API_HOST+"/Users", method: .post, parameters: userParams, encoding: JSONEncoding.default).responseJSON { response in
            if(response.response?.statusCode == 201){
                let sJson = JSON(response.result.value!)
                iduserCreated = sJson["id"].intValue
                
                //creando profile
                let profileParams : Parameters = [
                    "name":self.txtUsername.text!,
                    "type":"dev",
                    "status":"active",
                    "email":self.txtEmail.text!,
                    "phone":self.txtPhoneNumber.text!,
                    "age":self.txtAge.text!,
                    "sex":self.swcGender.isOn ? "male" : "female",
                    "coins":0,
                    "rating":2.5,
                    "address":self.txtAddress.text!,
                    "idUser":iduserCreated,
                    ]
                if(iduserCreated != 0){
                    Alamofire.request(self.app.API_HOST+"/Profiles", method: .post, parameters: profileParams, encoding: JSONEncoding.default).responseJSON { response in
                        if(response.response?.statusCode == 201){
                            let alert = UIAlertController(title: "SUCCESS", message: "Your account have been created!", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                                (action: UIAlertAction!) in
                                self.navigationController?.popViewController(animated: true)
                            }))
                        }
                    }
                }
                else{
                    print("error :(")
                }
            }
        }
        
        // fin
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
