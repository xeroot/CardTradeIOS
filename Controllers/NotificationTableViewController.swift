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
    var auctionscurrent_users = [AuctionCurrentUsers]() // FULL
    var auctionscurrent_usersAux = [AuctionCurrentUsers]()
    var mis_auctions = [Int]()
    var notificaciones = [Notification]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notificaciones.removeAll()
        let userDefaults = UserDefaults.standard
        let userId = userDefaults.integer(forKey: "UserId") //ok
       
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
                    self.auctionscurrent_usersAux.append(objAuCurrUsers) //
                }
                
                for  item in self.auctionscurrent_usersAux{
                    if(!self.mis_auctions.contains(item.idAuction) && item.idCurrentUser == userId){
                        self.mis_auctions.append(item.idAuction)
                    }
                }
                // listo ya llene los ids
                // ahora el paso 3
                for  item in self.mis_auctions{
                    print(String(item))
                }

                for  a in self.mis_auctions{
                    var last_user = userId
                    var card_name = ""
                    for  b in self.auctionscurrent_usersAux{
                        if(b.idAuction == a){
                            last_user = b.idCurrentUser
                            card_name = b.cardName
                        }
                    }
                    if(last_user != userId){
                        let nueva_notificacion = Notification()
                        nueva_notificacion.Name="Alguien te superó"
                        nueva_notificacion.Description="Un usuario te superó al pujar más alto para la carta " + card_name
                        self.notificaciones.append(nueva_notificacion)
                    }
                }
                
                // comprobacion
                for  item in self.notificaciones{
                    print(item.Name + " - " + item.Description)
                }
                self.tableView.reloadData()
                
                // hasta aqui todo bien, peeeero, puedes ir haciendo todo en uno xd, asi
                
           //     print(self.auctionscurrent_usersAux)
                /*
                for current in self.auctionscurrent_usersAux
                {
                    if(current.idCurrentUser  == userId)
                    {
                        let objAuCurrUsers = AuctionCurrentUsers()
                        objAuCurrUsers.id  = current.id
                        objAuCurrUsers.idCurrentUser  = current.idCurrentUser
                        objAuCurrUsers.amount  = current.amount
                        objAuCurrUsers.idAuction  = current.idAuction
                        objAuCurrUsers.cardName  = current.cardName
                        self.auctionscurrent_users.append(objAuCurrUsers)
                    }
                }
                for  item1 in self.auctionscurrent_users{
                    print("acaaa: " + String(item1.idCurrentUser))
                    
                }*/
            }
        }
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
       // self.notificaciones = getNotifications(myAuctions: AuctionCurrentUsers)
        
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notificaciones.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = notificaciones[indexPath.row].Name
        cell.detailTextLabel?.text = notificaciones[indexPath.row].Description
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
    

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
