//
//  TableViewController.swift
//  Task1
//
//  Created by macbook on 01.11.2020.
//

import UIKit
import Unrealm

class FriendsTableViewController: UITableViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var users: [[Friend]] = []
    var data: [Friend] = []
    var friends: Results<Friend>?
    var sections: [String] = []
    var searchResults : [Friend] = []
    var token: NotificationToken?
        
    @IBOutlet var frindsTableView: UITableView!
    
    func sortUser(_ items: [Friend]) {
        for crct in sections {
            var tmpItems: [Friend] = []
            
            for item in items {
                if crct == item.lastName.prefix(1) {
                    tmpItems.append(item)
                }
            }
            users.append(tmpItems)
        }
    }
    
    func loadFriends() {
        friends = Keeper.loadData(Friend.self)?.sorted(byKeyPath: "lastName")
        token = friends?.observe{ [weak self] (changes) in
            guard let tableView = self?.tableView else { return }
            switch changes {
//            case .initial:
//                tableView.reloadData()
//            //print("init friends")
//            case .update(_, let deletions, let insertions, let modifications):
//                tableView.beginUpdates()
//                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
//                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
//                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
//                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            default:
                self?.friends?.forEach {el in
                    self?.data.append(el)
                }
                guard let data = self?.data else { return }
                self?.sections = arrayFirstCaracterName(data)
                self?.sortUser(data)
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadFriends()
        
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        self.tableView.tableHeaderView = searchController.searchBar
        
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: "friendsCellId")
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    func filterContent(for searchText: String) {
        searchResults = data.filter({ (user: Friend) -> Bool in
        let match = user.firstName.range(of: searchText, options: .caseInsensitive)
            return match != nil
        })
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return searchController.isActive ? 1 : self.users.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? searchResults.count : self.users[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entry = searchController.isActive ? searchResults[indexPath.row] : users[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCellId", for: indexPath) as! FriendsTableViewCell

        cell.userNamelabel.text = "\(entry.firstName) \(entry.lastName)"
        cell.userAvatar.setCustomImage(entry.photo)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vController = storyboard.instantiateViewController(identifier: "details") as! CollectionViewController
        
        vController.testUser = self.users[indexPath.section][indexPath.row]
        self.navigationController?.pushViewController(vController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard sections.count > section else {
            return nil
        }
        let sectionLine = sections[section]
        
        return sectionLine
    }
}
