//
//  ButtonView.swift
//  Rapptr iOS Test Challenge
//
//  Created by Mitya Kim on 10/31/22.
//

import UIKit

class MenuButtonView: UIView {
    
    var button = UIButton()
    let imageView = UIImageView()
    let title: String
    let imageName: String
    
    init(frame: CGRect, title: String, imageName: String, button: UIButton) {
        self.title = title
        self.imageName = imageName
        self.button = button
        super.init(frame: .zero)

        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuButtonView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "view")
        alpha = 0.8
        layer.cornerRadius = 8
        
        imageView.image = UIImage(named: imageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor(named: "chatMessageText"), for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        addSubview(imageView)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            trailingAnchor.constraint(equalToSystemSpacingAfter: button.trailingAnchor, multiplier: 1),
            heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
