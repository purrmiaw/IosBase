//
//  AccountsTableViewController.swift
//  maraeps
//
//  Created by Authentic Venture Sdn Bhd on 12/06/2018.
//  Copyright © 2018 Authentic Venture Sdn Bhd. All rights reserved.
//

import UIKit

class AccountsTableViewController: UITableViewController {

    private var _activityIndicatorView: UIActivityIndicatorView?
    private var _noDataLabel: UILabel?
    private var _accountsTableSource: UITableViewDataSource?
    private var _stuffs: [Stuff] = [Stuff]()
    
    var fruits = ["Apple", "Apricot", "Banana", "Blueberry", "Cantaloupe", "Cherry",
                  "Clementine", "Coconut", "Cranberry", "Fig", "Grape", "Grapefruit",
                  "Kiwi fruit", "Lemon", "Lime", "Lychee", "Mandarine", "Mango",
                  "Melon", "Nectarine", "Olive", "Orange", "Papaya", "Peach",
                  "Pear", "Pineapple", "Raspberry", "Strawberry"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        // Init
        
        // Remove lines for empty cell
        tableView.tableFooterView = UIView()
        tableView.sectionFooterHeight = 0.01
        
        // Init Indicator
        _activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        view.addSubview(_activityIndicatorView!)
        _activityIndicatorView?.center = view.center
        _activityIndicatorView?.bringSubview(toFront: self.view)
        _activityIndicatorView?.startAnimating()
        
        // Init noDataLabel
        _noDataLabel = UILabel()
        _noDataLabel?.text = "No accounts yet"
        _noDataLabel?.textColor = UIColor.black
        _noDataLabel?.textAlignment = NSTextAlignment.center
        
        // Init TableView
        
        // Get Data
        //Implementing URLSession
        let urlString = "https://miaw.xyz/sampleapi/api/stuffs"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            //Implement JSON decoding and parsing
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                let stuffs = try JSONDecoder().decode([Stuff].self, from: data)
                
                //Get back to the main queue / thread
                DispatchQueue.main.async {
                    
                    self._stuffs = stuffs
                    
                    // quick reload
                    // self.tableView.reloadData()
                    
                    // nice reload
                    var indexPaths: [IndexPath] = [IndexPath]()
                    for i in 0..<self._stuffs.count {
                        
                        var indexPath: IndexPath = IndexPath(row: i, section: 0)
                        indexPaths.append(indexPath)
                    
                    }
                    
                    // stop loading animation
                    self._activityIndicatorView?.stopAnimating()
                    
                    self.tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
                    
                    
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
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
        return _stuffs.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        //cell.textLabel?.text = fruits[indexPath.row]
        cell.textLabel?.text = _stuffs[indexPath.row].name
        //cell.imageView?.image.im
        
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
