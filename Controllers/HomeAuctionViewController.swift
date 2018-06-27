//
//  HomeAuctionViewController.swift
//  CardTrade
//
//  Created by xer0 on 26/06/18.
//  Copyright © 2018 xer0. All rights reserved.
//

import UIKit

class HomeAuctionViewController: UIViewController {

    @IBOutlet weak var txtCardName: UILabel!
    @IBOutlet weak var txtUserName: UILabel!
    @IBOutlet weak var txtUserScore: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    @IBOutlet weak var txtTimeSpan: UILabel!
    @IBOutlet weak var txtCurrentAmount: UILabel!
    @IBOutlet weak var inputAmount: UITextField!
    
    var auctionSelected = Auction()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCardName.text = auctionSelected.cardName
        txtUserName.text = auctionSelected.userNameUserSeller
        txtUserScore.text = String(auctionSelected.calificationUser)
        txtDescription.text = auctionSelected.descriptionCard
        txtCurrentAmount.text = String(auctionSelected.currentAmount)+" Coins"
        
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
        print(timespan)
        txtTimeSpan.text = timespan
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btPujarPressed(_ sender: Any) {
        
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
