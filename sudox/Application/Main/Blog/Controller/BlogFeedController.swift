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
        tableView.easy.layout([Bottom(10).to(self.view.safeAreaLayoutGuide, .bottom),Top(0).to(self.view.safeAreaLayoutGuide, .top),Left(0),Right(0)])
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
        //MARK: firstCellSetup
        cell.userAvatarImage.image = UIImage(named: "smallNick")
        cell.userNameLabel.text = "Nick"
        cell.userDescriptionLabel.text = "rgbegbirgieufreiugbiugbiurebfeuibgreiugbireubgeiubgiuebgriuebguire"
        cell.changeProfileButton.setTitle("Change\nprofile")
        cell.newMomentButton.setTitle("Moment")
        cell.followersButton.setTitle("followers")
        cell.subscribesButton.setTitle("subscribes")
        cell.showMoreInformationButton.setTitle("Показать больше информации")
        cell.followersCountButton.setTitle("565к")
        cell.subscribesCountButton.setTitle("130")
        cell.showAvatarActionActivated = {[weak self] in
        }
        cell.changeProfileActioActivated = {[weak self] in
        }
        cell.addNewMomentActionActivated = {[weak self] in
        }
        cell.followersActionActivated = {[weak self] in
        }
        cell.subscribesActionActivated = {[weak self] in
        }
        cell.showMoreInformationActionActivated = {[weak self] in
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
