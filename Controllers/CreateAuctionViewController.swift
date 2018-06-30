//
//  CreateAuctionViewController.swift
//  CardTrade
//
//  Created by xer0 on 29/06/18.
//  Copyright © 2018 xer0. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class CreateAuctionViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    // picker methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cards.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cards[row].name
    }
    //
    var cards = [Card]()
    var app = CardTrade_AppConfing()
    
    @IBOutlet weak var pickerCard: UIPickerView!
    @IBOutlet weak var pickerEndDate: UIDatePicker!
    @IBOutlet weak var txtMinValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerCard.delegate = self
        pickerCard.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        Alamofire.request(app.API_HOST+"/Cards").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                let sJson = JSON(json)
                for (_,subJson):(String, JSON) in sJson {
                    // Do something you want
                    let objCard = Card()
                    objCard.name = subJson["name"].stringValue
                    objCard.idCard = subJson["id"].intValue
                    self.cards.append(objCard)
            }
                self.pickerCard.reloadAllComponents()
        }
        
        }
    }

    @IBAction func btCreateAuctionOnClick(_ sender: Any) {
        //Get category
        var cardId = 0
        let objCard : Card = self.cards[self.pickerCard.selectedRow(inComponent: 0)]
        cardId = objCard.idCard
        
        //get end data
        var endDate: String = ""
        //endDate = String(pickerEndDate.date)

        
        
        //Get user
        let userDefaults = UserDefaults.standard
        let userId : Int = userDefaults.integer(forKey: "UserId")
        
        //Set parameters
        /*let parameters : Parameters = [ "amount" : Double(self.txtMinValue.text!) ?? 0, "Tradable" : self.swtTradable.isOn, "Status" : "active", "UserId" : userId, "idCard" : cardId]
        
        Alamofire.request("http://vmdev1.nexolink.com:90/TruequeAppAPI/api/Items", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            print("Result Value: \(String(describing: response.result.value))")               // response serialization result
            
            switch(response.result){
            case .failure(_):
                let alert = UIAlertController(title: "Fail!", message: "Something went wrong! Please try again!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                break;
            case .success:                    self.navigationController?.popViewController(animated: true)
            break;*/
    }
    
}
