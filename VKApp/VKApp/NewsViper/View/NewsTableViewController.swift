//
//  NewsTableViewController.swift
//  Task1
//
//  Created by Pavel Khlebnikov on 12.07.2021.
//

import UIKit
import Unrealm
import RealmSwift

class NewsTableViewController: UITableViewController, NewsViewInputProtocol {
    
    @IBOutlet var newsTableView: UITableView!
    
    var viewOutput: NewsViewOutputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsId")
        viewOutput?.getNews()
    }

    func handleNewsChange() {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewOutput?.news?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsId", for: indexPath) as! NewsTableViewCell
        if let currentNews = viewOutput?.news?[indexPath.row] {
            cell.news = currentNews
            if currentNews.id ?? 0 >= 0 {
                if let author = Keeper.getObjectFromBase(currentNews.id ?? 0, type: Friend.self) {
                    cell.news?.screenName = "\(author.firstName) \(author.lastName)"
                    cell.news?.photoAuthor = author.photo
                }
            } else {
                if let author = Keeper.getObjectFromBase(currentNews.id ?? 0 * -1, type: MyGroup.self) {
                    cell.news?.screenName = author.screenName
                }
            }
        }
        return cell
    }
}
