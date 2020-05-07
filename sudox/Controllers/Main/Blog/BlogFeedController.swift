//
//  BlogFeedController.swift
//  sudox
//
//  Created by Никита Казанцев on 06.05.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import EasyPeasy
import UIKit

class BlogFeedController : UIViewController {
    lazy var tableView: UITableView = addTableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        tableView.reloadData()
    }
    private func addTableView() -> UITableView {
        //let nib = UINib(nibName: "MoreInfoInProfileTableViewCell", bundle: nil)
        let tableView = UITableView()
        tableView.register(MoreInfoInProfileTableViewCell.self, forCellReuseIdentifier: "MoreInfoInProfileTableViewCell")
        //tableView.register(nib, forCellReuseIdentifier: "MoreInfoInProfileTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        tableView.easy.layout([Bottom(10).to(self.view.safeAreaLayoutGuide, .bottom),Top(8).to(self.view.safeAreaLayoutGuide, .top),Left(0),Right(0)])
        //tableView.tableFooterView = UIView()
        return tableView
    }
}
extension BlogFeedController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension BlogFeedController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreInfoInProfileTableViewCell", for: indexPath) as! MoreInfoInProfileTableViewCell
        //cell.userAvatarImage.backgroundColor = .black
        cell.userAvatarImage.image = UIImage(named: "smallNick")
        cell.userAvatarImage.setRounded()
        let radius = cell.userAvatarImage.frame.width / 2
        cell.userAvatarImage.image = UIImage(named:"smallNick")
        cell.userAvatarImage.layer.cornerRadius = cell.userAvatarImage.frame.size.width / 2
        cell.userAvatarImage.clipsToBounds = true
        return cell
    }
}
