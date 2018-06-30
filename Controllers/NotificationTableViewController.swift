//
//  NotificationTableViewController.swift
//  CardTrade
//
//  Created by xer0 on 29/06/18.
//  Copyright © 2018 xer0. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NotificationTableViewController: UITableViewController {
    var app = CardTrade_AppConfing()
    var auctionscurrent_users = [AuctionCurrentUsers]()
    var mis_auctions = [Int]()
    var notificaciones = [Notification]()
    var comments = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMyAuctions(myAuctions: <#T##String#>)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
       // self.notificaciones = getNotifications(myAuctions: AuctionCurrentUsers)
        
    }
    func getMyAuctions(myAuctions : String){
        Alamofire.request(app.API_HOST+"/AuctionsCurrentUsers").responseJSON{
            response in
            if let json = response.result.value{
                print("JSON: \(json)") // serialized json response
                //Read json
                let sJson = JSON(json)
                for(_,subJson):(String,JSON) in sJson{
                    let objAuCurrUsers = AuctionCurrentUsers()
                    objAuCurrUsers.id = subJson["id"].intValue
                    objAuCurrUsers.idCurrentUser = subJson["idCurrentUser"].intValue
                    objAuCurrUsers.amount = subJson["amount"].intValue
                    objAuCurrUsers.idAuction = subJson["idAuction"].intValue
                    objAuCurrUsers.cardName = subJson["cardName"].stringValue
                    self.auctionscurrent_users.append(objAuCurrUsers)
                }
                
                
                self.tableView.reloadData()
            }
            
            guard let data = response.result.value else { return }
            
            let jsonData = JSON(data)
            let currentUserAuctions = jsonData["post-comments"].arrayObject as! [[String:String]]
            self.comments = currentUserAuctions.filter{$0["post"] != "new"}
           /* dispatch_get_main_queue().async() {
                self.tableView.reloadData()
            }*/
        }
    }
    
    /*func getNotifications(myAuctions : AuctionCurrentUsers) -> [Notification](){
        
        return nil
    }*/
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
