//
//  MoreInfoInProfileTableViewCell.swift
//  sudox
//
//  Created by Иван Лобанов on 07/05/2020.
//  Copyright © 2020 Sudox. All rights reserved.
//

import UIKit
import EasyPeasy

class MoreInfoInProfileTableViewCell: UITableViewCell {
    lazy var userAvatarImage: UIImageView = addUserAvatarImage()
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func addUserAvatarImage() -> UIImageView {
        let imageView1 = UIImageView()
        contentView.addSubview(imageView1)
        imageView1.easy.layout([Top(16).to(contentView.safeAreaLayoutGuide, .top), Left(16).to(contentView.safeAreaLayoutGuide, .left), Height(72), Width(72), Bottom(16).to(contentView.safeAreaLayoutGuide, .bottom)])
        imageView1.image = UIImage(named:"smallNick")
        imageView1.layer.cornerRadius = imageView1.frame.size.width / 2
        imageView1.clipsToBounds = true
        imageView1.setRounded()
        return imageView1
    }
    
}
