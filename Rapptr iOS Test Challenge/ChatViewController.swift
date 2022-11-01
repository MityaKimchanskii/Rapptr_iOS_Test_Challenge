//
//  ChatViewController.swift
//  Rapptr iOS Test Challenge
//
//  Created by Mitya Kim on 10/31/22.
//

import UIKit

class ChatViewController: UIViewController {
    
    // MARK: - Properties
    private var messages: [Message] = []
    
    // MARK: -  Views
    private let chatTableView = UITableView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chat"
        styleNavigationBar()
        style()
        layout()
        fetchAllMessages()
    }
}

// MARK: - Helper Methods
extension ChatViewController {
    private func style() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.id)
        chatTableView.backgroundColor = UIColor(named: "view")
        chatTableView.separatorColor = UIColor(named: "view")
        chatTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(chatTableView)
        
        NSLayoutConstraint.activate([
            chatTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchAllMessages() {
        ChatClient.shared.fetchChatData { [weak self] result in
            switch result {
            case .success(let messages):
                DispatchQueue.main.async {
                    self?.messages = messages
                    self?.chatTableView.reloadData()
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - TableView Delegate and DataSource
extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.id, for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
        let message = messages[indexPath.row]
        cell.selectionStyle = .none
        cell.message = message
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
