//
//  HomeTableViewController.swift
//  CardTrade
//
//  Created by xer0 on 26/06/18.
//  Copyright © 2018 xer0. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

/*
extension UITableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    public func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}*/

class HomeTableViewController: UITableViewController {

    var app = CardTrade_AppConfing()
    var allAuctions = [Auction]()
    var selectedRow : Int = 0
    
    //let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        // Alamo fire
        allAuctions.removeAll()
        Alamofire.request(app.API_HOST+"/Auctions").responseJSON(){
            response in
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                let sJSON = JSON(json)
                // The `index` is 0..<json.count's string value
                for (_,subJson):(String, JSON) in sJSON {
                    // Do something you want
                    let auction = Auction()
                    auction.amount = subJson["Amount"].intValue
                    auction.userNameUserSeller = subJson["UsernameUserSeller"].stringValue
                    auction.cardName = subJson["CardName"].stringValue
                    auction.beginDate = subJson["BeginDate"].stringValue
                    auction.endDate = subJson["EndDate"].stringValue
                    auction.cardId = subJson["CardId"].intValue
                    auction.descriptionCard = subJson["DescriptionCard"].stringValue
                    auction.currentAmount = subJson["CurrentAmount"].intValue
                    auction.id = subJson["Id"].intValue
                    self.allAuctions.append(auction)
                }
                self.tableView.reloadData()
            }
        }
    }
    
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
        return allAuctions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "auctionCell", for: indexPath)
        // Configure the cell...
        let detalle : String = "Current Amount: "+String(allAuctions[indexPath.row].currentAmount)+" - End Date: "+allAuctions[indexPath.row].endDate
        cell.detailTextLabel?.text = detalle
        cell.textLabel?.text = allAuctions[indexPath.row].cardName
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "showItem", sender: self)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "showItem"){
            if let nextController = segue.destination as? HomeAuctionViewController{
                nextController.auctionSelected = allAuctions[self.selectedRow]
            }
        }
    }

}
