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

class HomeTableViewController: UITableViewController, UISearchBarDelegate{

    var app = CardTrade_AppConfing()
    var selectedRow : Int = 0
    @IBOutlet weak var searchBar: UISearchBar!
    var allAuctions = [Auction]()
    var filteredAuctions = [Auction]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
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
                self.filteredAuctions = self.allAuctions
                self.tableView.reloadData()
            }
        }
        //self.filteredAuctions = self.allAuctions
        //self.tableView.reloadData()
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
        return filteredAuctions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "auctionCell", for: indexPath)
        // Configure the cell...
        var detalle : String = "Current Amount: "+String(filteredAuctions[indexPath.row].currentAmount)+" \nEnd Date: "+filteredAuctions[indexPath.row].endDate
        detalle = detalle.replacingOccurrences(of: "T", with: " ")
        cell.detailTextLabel?.numberOfLines=2;
        cell.detailTextLabel?.text = detalle
        cell.textLabel?.text = filteredAuctions[indexPath.row].cardName
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "showItem", sender: self)
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredAuctions = searchText.isEmpty ? allAuctions : allAuctions.filter { (item: Auction) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.cardName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
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
                nextController.auctionSelected = filteredAuctions[self.selectedRow]
            }
        }
    }

}
