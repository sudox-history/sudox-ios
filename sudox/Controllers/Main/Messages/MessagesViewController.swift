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
        chatsListData.append(messagesListStruct(name: "Никита Казанцев", id: "buFKx4meCBN3LtGmACJs55vCFca8Guhc", lastMessage: "О, опять обогнали Android в прогрессе", timeOfLastMessage: Date().addingTimeInterval(-15000), isOnline: false, numberOfUnread: 105, isMuted: true))
        chatsListData.append(messagesListStruct(name: "Никита Казанцев", id: "USAxWDpxyWy2KQBqrs6gqqJ7mc2E84wz", lastMessage: "О, опять обогнали Android в прогрессе", timeOfLastMessage: Date().addingTimeInterval(-86400), isOnline: true, numberOfUnread: 2, isMuted: false))
        chatsListData.append(messagesListStruct(name: "Никита Казанцев", id: "buFKx4meCBN3LtGmACJs55vCFca8Guhc", lastMessage: "О, опять обогнали Android в прогрессе", timeOfLastMessage: Date().addingTimeInterval(-172800), isOnline: false, numberOfUnread: 105, isMuted: true))
        chatsListData.append(messagesListStruct(name: "Никита Казанцев", id: "USAxWDpxyWy2KQBqrs6gqqJ7mc2E84wz", lastMessage: "О, опять обогнали Android в прогрессе", timeOfLastMessage: Date().addingTimeInterval(-691200), isOnline: true, numberOfUnread: 2, isMuted: false))
        chatsListData.append(messagesListStruct(name: "Никита Казанцев", id: "buFKx4meCBN3LtGmACJs55vCFca8Guhc", lastMessage: "О, опять обогнали Android в прогрессе", timeOfLastMessage: Date().addingTimeInterval(-47304000), isOnline: false, numberOfUnread: 105, isMuted: true))
        chatsListData.append(messagesListStruct(name: "Никита Казанцев", id: "USAxWDpxyWy2KQBqrs6gqqJ7mc2E84wz", lastMessage: "О, опять обогнали Android в прогрессе", timeOfLastMessage: Date(), isOnline: true, numberOfUnread: 2, isMuted: false))
        tableView.reloadData()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.systemBackground
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
        let currentChatinList = chatsListData[indexPath.row] // создаю переменную с отдельным чатом
        let dateString = currentChatinList.timeOfLastMessage.timeAgoSinceDateForDialogue(nowTime: Date()) // время с последнего сообщения
        cell.timeOfLastMessageLabel.text = dateString
        cell.nameLabel.text = currentChatinList.name
        
        cell.lastMessageLabel.text = currentChatinList.lastMessage
        if currentChatinList.isMuted {
            cell.lastMessageLabel.textColor = UIColor.systemGray
            cell.numberOfUnreadLabel.backgroundColor = UIColor.systemGray2
            cell.sizeOfLastMessageLabel.constant = 19
            
        } else {
            cell.numberOfUnreadLabel.backgroundColor = getColor().mainColor
        }
        if currentChatinList.numberOfUnread == 0 {
            cell.numberOfUnreadLabel.isHidden = true
            cell.sizeOfLastMessageLabel.constant = 19
        } else {
            cell.numberOfUnreadLabel.text = String(currentChatinList.numberOfUnread)
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let date = Date()
        let calendar = Calendar.current
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
