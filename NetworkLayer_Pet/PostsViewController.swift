//
//  PostsViewController.swift
//  NetworkRouter
//
//  Created by Evgeniy Stoyan on 09.09.2024.
//  Copyright © 2024 com.gmail@sev1001. All rights reserved.
//

import UIKit
import NetworkAPI

class PostsViewController: UIViewController {
    private struct Constants {
        static let estimatedRowHeight: CGFloat = 50
        static let automaticDimension = UITableView.automaticDimension
    }
    
    //MARK: - Outlets
    lazy private var postsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostsTableViewCell.self)
        return tableView
    }()
    //MARK: - Private properties
    private let service: HTTPService
    private var posts = Posts()
    
    //MARK: - Lifecycle
    init(networkService: HTTPService) {
        self.service = networkService
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadPosts()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(postsTableView)
        postsTableView.constraints(toAnchors: .top(view.layoutMarginsGuide.topAnchor),
                                   .bottom(view.layoutMarginsGuide.bottomAnchor),
                                   .leading(view.layoutMarginsGuide.leadingAnchor),
                                   .trailing(view.layoutMarginsGuide.trailingAnchor))
    }
    private func loadPosts() {
        let endpoint = HTTPRouter.posts.endpoint
        service.fetch(endpoint: endpoint, type: Posts.self, receiveOn: .main) {[weak self] result in
            guard let self else {return}
            switch result {
            case let .success(posts):
                self.posts = posts
                self.postsTableView.reloadData()
            case let .failure(error):
                print("Present alert view with message text: \(error.localizedDescription)")
            case .cancelled:
                print("Operation is cancelled")
            }
        }
    }
}
//MARK: - UITableViewDelegate & UITableViewDataSource
extension PostsViewController: UITableViewDelegate,
                               UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configureUI(post: posts[indexPath.item])
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.estimatedRowHeight
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.automaticDimension
    }
}
