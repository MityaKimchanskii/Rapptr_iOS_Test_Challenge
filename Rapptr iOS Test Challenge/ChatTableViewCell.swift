//
//  ChatTableViewCell.swift
//  Rapptr iOS Test Challenge
//
//  Created by Mitya Kim on 10/31/22.
//

import UIKit
import SDWebImage

class ChatTableViewCell: UITableViewCell {

    // MARK: - Properties
    var message: Message? {
        didSet {
            updateViews()
        }
    }
    
    static let id: String = "messageCell"
    private let widthAndHeightProfileImage: CGFloat = 50
    
    // MARK: - Views
    private let nameLabel = UILabel()
    private let bodyLabel = UILabel()
    private lazy var bubbleView = BubbleView(frame: .zero, label: bodyLabel, text: message?.text ?? "")
    private let profileImageView = UIImageView()
    
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleCell()
        layoutCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helper Methods
extension ChatTableViewCell {
    private func updateViews() {
        guard let message = message else { return }
        nameLabel.text = message.username
        bodyLabel.text = message.text
        setProfileImage()
    }
    
    private func setProfileImage() {
        guard let http = message?.avatarURL else { return }
        var comps = URLComponents(url: http, resolvingAgainstBaseURL: false)
        comps?.scheme = "https"
        let httpsURL = comps?.url
        DispatchQueue.main.async {
            self.profileImageView.sd_setImage(with: httpsURL)
        }
    }
    
    private func styleCell() {
        backgroundColor = UIColor(named: "view")
        // profileImageView
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = widthAndHeightProfileImage/2
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // nameLabel
        nameLabel.textColor = UIColor(named: "chatUserNameText")
        nameLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
       
    }
    
    private func layoutCell() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bubbleView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            profileImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            profileImageView.heightAnchor.constraint(equalToConstant: widthAndHeightProfileImage),
            profileImageView.widthAnchor.constraint(equalToConstant: widthAndHeightProfileImage),
            
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 7),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            bubbleView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            bubbleView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 7),
            trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: 36)
        ])
       
    }
}
