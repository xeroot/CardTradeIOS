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
    
    var auctionSelected = Auction()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCardName.text = auctionSelected.cardName
        txtUserName.text = auctionSelected.userNameUserSeller
        txtUserScore.text = String(auctionSelected.calificationUser)
        txtDescription.text = auctionSelected.descriptionCard
        txtCurrentAmount.text = String(auctionSelected.currentAmount)
        
        
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
