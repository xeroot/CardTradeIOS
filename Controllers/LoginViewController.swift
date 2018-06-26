//
//  LoginViewController.swift
//  CardTrade
//
//  Created by xer0 on 23/06/18.
//  Copyright © 2018 xer0. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    var app = CardTrade_AppConfing()
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ya :v
    @IBAction func btnLoginPressed(_ sender: Any) {
        //Validate login
        Alamofire.request(app.API_HOST+"/Users?username=" + txtUsername.text! + "&password=" + txtPassword.text!).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
            
            let sJson = JSON(response.result.value)
            if(sJson["Id"] != JSON.null){
              //  print(sJson["Id"])
               // print(sJson["Name"])
               // print(sJson["Rating"])
               
                
                let userDefaults = UserDefaults.standard
                userDefaults.set(sJson["Id"].intValue, forKey: "UserId")
                
                self.performSegue(withIdentifier: "login", sender: nil)
            }
            else{
                let alert = UIAlertController(title: "Fail!", message: "Invalid credentials!", preferredStyle: UIAlertControllerStyle.actionSheet)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
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
