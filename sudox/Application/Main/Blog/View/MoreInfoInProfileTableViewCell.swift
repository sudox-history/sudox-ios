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
    //MARK: UIElements
    var userAvatarImage = UIImageView()
    var userNameLabel = UILabel()
    var userDescriptionLabel = UILabel()
    var changeProfileImageButton = ButtonWithMagic()
    var changeProfileButton = ButtonWithMagic()
    var newMomentImageButton = ButtonWithMagic()
    var newMomentButton = ButtonWithMagic()
    var followersCountButton = UIButton()
    var followersButton = UIButton()
    var subscribesCountButton = UIButton()
    var subscribesButton = UIButton()
    var showMoreInformationButton = UIButton()
    //MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addUserAvatarImage()
        addUserNameLabel()
        addUserDescriptionLabel()
        addChangeProfileImageButton()
        addChangeProfileButton()
        addNewMomentImageButton()
        addNewMomentButton()
        addFollowersCountButton()
        addFollowersButton()
        addSubscribesCountButton()
        addSubscribesButton()
        addShowMoreInformationButton()
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: userInfo
    private func addUserAvatarImage() {
        contentView.addSubview(userAvatarImage)
        let imageSize: CGFloat = 72
        userAvatarImage.easy.layout([Top(16).to(contentView.safeAreaLayoutGuide, .top), Left(16).to(contentView.safeAreaLayoutGuide, .left), Height(imageSize), Width(imageSize)]) //layoutIfNeeded()
        userAvatarImage.image = UIImage(named:"smallNick")
        userAvatarImage.layer.cornerRadius = imageSize / 2
        userAvatarImage.clipsToBounds = true
    }
    private func addUserNameLabel() {
        let label = userNameLabel
        contentView.addSubview(userNameLabel)
        userNameLabel.easy.layout([Left(20).to(userAvatarImage), Right(92).to(contentView.safeAreaLayoutGuide, .right), Top(22).to(contentView.safeAreaLayoutGuide, .top), Height(24)])
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.label
        
    }
    private func addUserDescriptionLabel() {
        let label = userDescriptionLabel
        contentView.addSubview(label)
        label.easy.layout([Left(20).to(userAvatarImage), Right(92).to(contentView.safeAreaLayoutGuide, .right), Top(0).to(userNameLabel), Height(38)])
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.systemGray2
        label.numberOfLines = 0
    }
    //MARK: ChangeProfile
    private func addChangeProfileImageButton() {
        let button = changeProfileImageButton
        contentView.addSubview(button)
        button.setImage(UIImage(systemName: "pencil"))
        button.contentMode = .scaleAspectFit
        button.tintColor = getColor().mainColor
        button.easy.layout([Top(32).to(contentView.safeAreaLayoutGuide, .top), Height(24), Width(55), Right(16).to(contentView.safeAreaLayoutGuide, .right)])
        button.addTarget(self, action: #selector(changeProfileAction), for: .touchUpInside)
        
    }
    private func addChangeProfileButton() {
        let button = changeProfileButton
        contentView.addSubview(button)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        button.easy.layout([Top(0).to(changeProfileImageButton),Right(16).to(contentView.safeAreaLayoutGuide, .right), Height(38), Width(55)])
        button.setTitleColor(getColor().mainColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(changeProfileAction), for: .touchUpInside)
    }
    //MARK: NewMoment
    private func addNewMomentImageButton() {
        let button = newMomentImageButton
        contentView.addSubview(button)
        button.setImage(UIImage(systemName: "perspective"))
        button.contentMode = .scaleAspectFit
        button.tintColor = getColor().mainColor
        button.easy.layout([Top(12).to(userAvatarImage), Height(24), Width(70), Left(16).to(contentView.safeAreaLayoutGuide, .left)])
        button.addTarget(self, action: #selector(addNewMomentAction), for: .touchUpInside)
    }
    private func addNewMomentButton() {
        let button = newMomentButton
        contentView.addSubview(button)
        //button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        button.easy.layout([Top(0).to(newMomentImageButton), Height(19), Width(70), Left(16).to(contentView.safeAreaLayoutGuide, .left)])
        button.setTitleColor(getColor().mainColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(addNewMomentAction), for: .touchUpInside)
    }
    //MARK: Followers
    private func addFollowersCountButton() { //count
        let button = followersCountButton
        contentView.addSubview(button)
        button.easy.layout([Top(12).to(userAvatarImage), Height(24), Width(70), Left(20).to(newMomentImageButton)])
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(UIColor.label, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(followersAction), for: .touchUpInside)
    }
    private func addFollowersButton() {
        let button = followersButton
        contentView.addSubview(button)
        //button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        button.easy.layout([Top(0).to(followersCountButton), Height(19), Width(70), Left(16).to(newMomentButton)])
        button.setTitleColor(UIColor.systemGray2, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(followersAction), for: .touchUpInside)
    }
    //MARK: Subscribes
    private func addSubscribesCountButton() { //count
        let button = subscribesCountButton
        contentView.addSubview(button)
        button.easy.layout([Top(12).to(userAvatarImage), Height(24), Width(70), Left(20).to(followersCountButton)])
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(UIColor.label, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(subscribesAction), for: .touchUpInside)
    }
    private func addSubscribesButton() {
        let button = subscribesButton
        contentView.addSubview(button)
        //button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        button.easy.layout([Top(0).to(followersCountButton), Height(19), Width(80), Left(16).to(followersButton)])
        button.setTitleColor(UIColor.systemGray2, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(subscribesAction), for: .touchUpInside)
    }
    //MARK: ShowMoreInformation
    private func addShowMoreInformationButton() {
        let button = showMoreInformationButton
        contentView.addSubview(button)
        button.easy.layout([CenterX(), Top(16).to(followersButton), Bottom(16).to(contentView.safeAreaLayoutGuide, .bottom)])
        button.setTitleColor(UIColor.systemGray2, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(showMoreInformationAction), for: .touchUpInside)
    }
    //MARK: actions
    var showAvatarActionActivated: (() -> Void)?//вызывает действие на экране с
    @objc private func showAvatarAction() {
        print("showAvatar")
        showAvatarActionActivated?()
    }
    var changeProfileActioActivated: (() -> Void)?
    @objc private func changeProfileAction() {
        print("changeProfile")
        changeProfileActioActivated?()
    }
    var addNewMomentActionActivated: (() -> Void)?
    @objc private func addNewMomentAction() {
        print("addNewMoment")
        addNewMomentActionActivated?()
    }
    var followersActionActivated: (() -> Void)?
    @objc private func followersAction() {
        print("followers")
        followersActionActivated?()
    }
    var subscribesActionActivated: (() -> Void)?
    @objc private func subscribesAction() {
        print("subscribes")
        subscribesActionActivated?()
    }
    var showMoreInformationActionActivated: (() -> Void)?
    @objc private func showMoreInformationAction() {
        print("showMoreInformationAction")
        showMoreInformationActionActivated?()
    }
}
