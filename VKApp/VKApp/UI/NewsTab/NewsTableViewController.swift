//
//  NewsTableViewController.swift
//  Task1
//
//  Created by Pavel Khlebnikov on 12.07.2021.
//

import UIKit
import Unrealm

class NewsTableViewController: UITableViewController {

    @IBOutlet var newsTableView: UITableView!
    
    var news: Results<MyNews>?
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsId")
        loadNews()
    }

    func loadNews() {
        news = Keeper.loadData(MyNews.self)
        token = news?.observe{ [weak self] (changes) in
            guard let tableView = self?.newsTableView else { return }
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
        return news?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsId", for: indexPath) as! NewsTableViewCell
        if let currentNews = news?[indexPath.row] {
            cell.news = currentNews
            if currentNews.id ?? 0 >= 0 {
                if let author = Keeper.getUserFromBase(currentNews.id ?? 0) {
                    cell.news?.screenName = "\(author.firstName) \(author.lastName)"
                    cell.news?.photoAuthor = author.photo
                }
            } else {
                if let author = Keeper.getGroupFromBase(currentNews.id ?? 0 * -1) {
                    cell.news?.screenName = author.screenName
                }
            }
        }
        return cell
    }
}
