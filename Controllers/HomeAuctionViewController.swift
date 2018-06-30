//
//  HomeAuctionViewController.swift
//  CardTrade
//
//  Created by xer0 on 26/06/18.
//  Copyright © 2018 xer0. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeAuctionViewController: UIViewController {
    var app = CardTrade_AppConfing()

    @IBOutlet weak var txtCardName: UILabel!
    @IBOutlet weak var txtUserName: UILabel!
    @IBOutlet weak var txtUserScore: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    @IBOutlet weak var txtTimeSpan: UILabel!
    @IBOutlet weak var txtCurrentAmount: UILabel!
    @IBOutlet weak var inputAmount: UITextField!
    @IBOutlet weak var imgCard: UIImageView!
    
    var auctionSelected = Auction()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCardName.text = auctionSelected.cardName
        txtUserName.text = auctionSelected.userNameUserSeller
        txtUserScore.text = String(auctionSelected.calificationUser)
        txtDescription.text = "Description: \n"+auctionSelected.descriptionCard
        txtCurrentAmount.text = String(auctionSelected.currentAmount)+" Coins"
        
        // Get time left
        RefreshTime()
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RefreshTime), userInfo: nil, repeats: true)
        
        // Imagen
        let url = URL(string: "https://i.pinimg.com/originals/bd/1f/02/bd1f022c291a7a2b6dc627d0ca35d2a2.jpg")
        let data = try? Data(contentsOf: url!)
        imgCard.image = UIImage(data: data!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btPujarPressed(_ sender: Any) {
        if(Int(self.inputAmount.text!)! < Int(Double(auctionSelected.currentAmount)*1.2)){
            let alert = UIAlertController(title: "Bad Amount", message: "Your amount must be higher or equal than: "+String(Int(Double(auctionSelected.currentAmount)*1.2)), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let params : Parameters = [
                "Id": auctionSelected.id,
                "CurrentAmount": self.inputAmount.text!
            ]
            let userDefaults = UserDefaults.standard
            let userId : Int = userDefaults.integer(forKey: "UserId")
            
            // PUT // UPDATE AUCTION
            Alamofire.request(app.API_HOST+"/Auctions?id="+String(auctionSelected.id)+"&idUser="+String(userId), method: .put, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
                if(response.response?.statusCode == 200){
                    let alert = UIAlertController(title: "SUCCESS", message: "You have submited your Amount!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                        (action: UIAlertAction!) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                else if(response.response?.statusCode == 306){
                    let alert = UIAlertController(title: "Fail!", message: "You dont have coins enought!!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    let alert = UIAlertController(title: "Fail!", message: "Something went wrong! Please try again!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func RefreshTime() {
        // mostrar tiempo restante
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //2018-06-23T00:00:00
        //let instaFormated : Date? = dateFormatter.date(from: iniDate)
        let iniDate = Date()
        let endDate = dateFormatter.date(from: auctionSelected.endDate)
        let difference = endDate?.timeIntervalSince(iniDate)
        let difH = Int(difference!/(60*60))
        let difM = Int(difference!/(60))%60
        let difS = Int(difference!)%60
        let timespan = "Hours: "+String(difH)+", Minutes: "+String(difM)+", Seconds: "+String(difS)
        //print(timespan)
        txtTimeSpan.text = timespan
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
