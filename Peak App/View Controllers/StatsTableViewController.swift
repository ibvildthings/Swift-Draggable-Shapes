//
//  StatsTableViewController.swift
//  Peak App
//
//  Created by Pritesh Desai on 5/29/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

import UIKit

class StatsTableViewController: UITableViewController {

    // Used to keep count of shapes
    var shapeCount: [Shape : Int] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set title in the nav bar
        title = "Stats"
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
        return shapeCount.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Display stats
        cell.textLabel?.text = Array(shapeCount.keys)[indexPath.row].rawValue
        cell.detailTextLabel?.text = String(Array(shapeCount.values)[indexPath.row])

        return cell
    }
    

}
