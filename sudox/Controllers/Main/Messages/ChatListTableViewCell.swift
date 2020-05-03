//
//  ChatListTableViewCell.swift
//  sudox
//
//  Created by Иван Лобанов on 26/04/2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeOfLastMessageLabel: UILabel!
    
    @IBOutlet weak var numberOfUnreadLabel: PaddingLabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.setRounded()
        nameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        lastMessageLabel.font = UIFont.systemFont(ofSize: 14)
        timeOfLastMessageLabel.textColor = UIColor.systemGray
        numberOfUnreadLabel.textColor = UIColor.white
        numberOfUnreadLabel.layer.masksToBounds = true;
        numberOfUnreadLabel.layer.cornerRadius = self.numberOfUnreadLabel.frame.size.width / 2 //правильное закругление
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
