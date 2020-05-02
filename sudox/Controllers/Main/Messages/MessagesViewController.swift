//
//  MessagesViewController.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 11.03.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import UIKit
import EasyPeasy

class MessagesViewController : UIViewController {
    var timer = Timer()
    var chatsListData = [messagesListStruct]()//пока что статичный массив, потом подключаем веб..
    lazy var tableView: UITableView = addTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(updateTableView), userInfo: nil, repeats: true);
        chatsListData.append(messagesListStruct(name: "Никита Казанцев", id: "USAxWDpxyWy2KQBqrs6gqqJ7mc2E84wz", lastMessage: "О, опять обогнали Android в прогрессе", timeOfLastMessage: Date(), isOnline: true, numberOfUnread: 2, isMuted: false))
        chatsListData.append(messagesListStruct(name: "Никита Казанцев", id: "buFKx4meCBN3LtGmACJs55vCFca8Guhc", lastMessage: "О, опять обогнали Android в прогрессе", timeOfLastMessage: Date(), isOnline: false, numberOfUnread: 105, isMuted: true))
        tableView.reloadData()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.systemBackground
        //self.title = "Messages"
        //self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addTableView() -> UITableView {
        let nib = UINib(nibName: "ChatListTableViewCell", bundle: nil)
        let tableView = UITableView()
        tableView.register(nib, forCellReuseIdentifier: "ChatListTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        tableView.easy.layout([Bottom(10).to(self.view.safeAreaLayoutGuide, .bottom),Top(8).to(self.view.safeAreaLayoutGuide, .top),Left(0),Right(0)])
        //tableView.tableFooterView = UIView()
        return tableView
    }
    private func getCurrentDate()-> Date {
        let date = Date()
        return date
    }
    @objc private func updateTableView() {
        tableView.reloadData()
    }
    
    
    
}
extension MessagesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension MessagesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatsListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListTableViewCell", for: indexPath) as! ChatListTableViewCell
        let dateString = chatsListData[indexPath.row].timeOfLastMessage.timeAgoSinceDate
        cell.timeOfLastMessageLabel.text = dateString()
        cell.nameLabel.text = chatsListData[indexPath.row].name
        
        cell.lastMessageLabel.text = chatsListData[indexPath.row].lastMessage
        if chatsListData[indexPath.row].isMuted {
            cell.lastMessageLabel.textColor = UIColor.systemGray
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let date = Date()
        let calendar = Calendar.current
        print(calendar.locale)
        print(calendar.firstWeekday)
        let weekday = calendar.component(.weekday, from: date)
        print(weekday)
        let exampleDate = Date().addingTimeInterval(-15000)
        print ()
        // ask for the full relative date
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated

        // get exampleDate relative to the current date
        let relativeDate = formatter.localizedString(for: exampleDate, relativeTo: Date())

        // print it out
        print("Relative date is: \(relativeDate)")
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
