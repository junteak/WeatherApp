//
//  TableViewController.swift
//  WeatherApp
//
//  Created by 潤田中 on 2019/06/15.
//  Copyright © 2019 BCC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage


class TableViewController: UITableViewController {
    
    //都道府県柄型の都道府県データを配列でとる
    var prefectures: [Pref] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Alamofireを利用して通信を行います
        Alamofire.request("https://script.google.com/macros/s/AKfycbyFEiNBHOJcs5pGhh1JuKsK17moh3C6TDHD31Gk01NCPcZcwdcA/exec").responseJSON { (response: DataResponse<Any>) in
            
            
            
            if response.result.isFailure == true {
                self.simpleAlert(title: "通信エラー", message: "通信に失敗しました")
                return
            }
            
            // "guard let 変数 〜 else" で変数の中身がnilの場合のみの処理が書けます。
            // ただし最後に必ずreturnで関数を終了させなければいけません。
            // 変数は以後の関数内でも利用できます。
            
            guard let val = response.result.value as? [String: Any] else {
                self.simpleAlert(title: "通信エラー", message: "通信結果がJSONではありませんでした")
                return
            }
            
            let json = JSON(val)
            
            let prefJSON = json["rss"]["channel"]["source"]["pref"].arrayValue
            
            
            self.prefectures = prefJSON.map({ item in
                return Pref(pref: item)
                
            })
            print(prefJSON)
            //重要！！！！！！！！これがないと表示されない！！！！！！！
            self.tableView.reloadData()
        }
    }
    
    
    // アラートの関数
    
    func simpleAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "閉じる", style: .cancel, handler: nil))
    }
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return prefectures.count
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let cities = prefectures[section].cities
        
        return cities.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return prefectures[section].title
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prefCell", for: indexPath) as! TableViewCell
        
        
        cell.titleLabel.text = prefectures[indexPath.section].cities[indexPath.row].title
        
        
        cell.idLabel.text = prefectures[indexPath.section].cities[indexPath.row].id
        
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
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
  
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController {
            
            if let cell = sender as? TableViewCell, let indexPath = tableView.indexPath(for: cell) {
                detailVC.cityID = prefectures[indexPath.section].cities[indexPath.row].id
                
            }
        }
    }
}
