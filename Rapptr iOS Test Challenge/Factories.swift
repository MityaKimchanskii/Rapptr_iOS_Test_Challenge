//
//  Factories.swift
//  Rapptr iOS Test Challenge
//
//  Created by Mitya Kim on 10/31/22.
//

import UIKit

extension UIViewController {
    func styleNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "header")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "headerText") ?? .white]
        appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(dismissSelf))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }

    @objc private func dismissSelf() {
        dismiss(animated: true)
    }
}





