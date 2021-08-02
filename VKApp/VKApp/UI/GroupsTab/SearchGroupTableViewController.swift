//
//  TableViewControllerSearchGroup.swift
//  Task1
//
//  Created by macbook on 05.11.2020.
//

import UIKit

class SearchGroupTableViewController: UITableViewController {

    @IBOutlet var searchGroupTableView: UITableView!
    
    var data = createGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_2_2", for: indexPath) as! SearchGroupTableViewCell

        cell.nameGroupLabel.text = "\(self.data[indexPath.row])"
        cell.avatarGroupImageView.image = self.data[indexPath.row].avatar

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    /*
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editGroup = UITableViewRowAction(style: .normal, title: "вступить в группу") { [self] action, index in data.remove(at: indexPath.row); tableView.reloadData()}
        
        return [editGroup]
    }
    */

}
