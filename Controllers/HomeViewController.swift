//
//  HomeViewController.swift
//  CardTrade
//
//  Created by xer0 on 24/06/18.
//  Copyright © 2018 xer0. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var app = CardTrade_AppConfing()
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
        
        cell.lblItem.text = item[indexPath.row]
        cell.lblPrice.text  = price[indexPath.row]
        cell.lblTime.text = time[indexPath.row]
        cell.imgItem.image = image[indexPath.row]
        return cell
        
    }
    
   
    let item = ["tem1","item2","iten3","item4"]
    let time = ["time1","item2","item3","item4"]
    let price = ["price1","price2","price3","price4"]
    let image  = [UIImage(named: "dataset-original"),UIImage(named: "dataset-original"),UIImage(named: "dataset-original"),UIImage(named: "dataset-original")]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.count
    }
    /*func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)-> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
        
        cell.lblItem.text = item[indexPath.row]
        cell.lblPrice.text  = price[indexPath.row]
        cell.lblTime.text = time[indexPath.row]
        cell.imgItem.image = image[indexPath.row]
        
        return cell
    }*/
    
        
        
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
