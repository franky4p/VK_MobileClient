//
//  TableViewControllerGroup.swift
//  Task1
//
//  Created by macbook on 01.11.2020.
//

import UIKit
import Unrealm

class GroupTableViewController: UITableViewController {

    @IBOutlet var groupTableView: UITableView!
    
    var groups: Results<MyGroup>?
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGroup()
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "groupCellId")
    }

    func loadGroup() {
        groups = Keeper.loadData(MyGroup.self)
        token = groups?.observe{ [weak self] (changes) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCellId", for: indexPath) as! GroupTableViewCell

        cell.groupNameLabel.text = "\(groups?[indexPath.row].name ?? "")"
        cell.avatarGropImageView.setCustomImage(groups?[indexPath.row].photo)

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let editGroup = UITableViewRowAction(style: .normal, title: "Выйти из группы") { [self] action, index in data.remove(at: indexPath.row); tableView.reloadData()}
//
//        return [editGroup]
//    }

}
