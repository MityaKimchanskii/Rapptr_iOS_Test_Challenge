//
//  TextFieldView.swift
//  Rapptr iOS Test Challenge
//
//  Created by Mitya Kim on 10/31/22.
//

import UIKit

class TextFieldView: UIView {
    
    private var textField = UITextField()
    
    init(frame: CGRect, textField: UITextField) {
        self.textField = textField
        super.init(frame: .zero)

        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TextFieldView {
    private func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "view")
        alpha = 0.5
        layer.cornerRadius = 8
        
        textField.backgroundColor = UIColor(named: "view")
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 3),
            trailingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 3),
            heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
