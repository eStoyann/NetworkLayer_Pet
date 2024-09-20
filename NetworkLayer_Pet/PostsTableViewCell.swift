//
//  PostsTableViewCell.swift
//  NetworkRouter
//
//  Created by Evgeniy Stoyan on 09.09.2024.
//  Copyright © 2024 com.gmail@sev1001. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    lazy private var postTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    lazy private var postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .natural
        return label
    }()
    lazy private var postContentStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 7
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        postContentStackView.addArrangedSubview(postTitleLabel)
        postContentStackView.addArrangedSubview(postDescriptionLabel)
        contentView.addSubview(postContentStackView)
        postContentStackView.constraints(toAnchors:
                .top(contentView.layoutMarginsGuide.topAnchor), .bottom(contentView.layoutMarginsGuide.bottomAnchor), .leading(contentView.layoutMarginsGuide.leadingAnchor), .trailing(contentView.layoutMarginsGuide.trailingAnchor))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        postTitleLabel.attributedText = nil
        postDescriptionLabel.attributedText = nil
    }
    
    //MARK: - UI
    func configureUI(post: Post) {
        postTitleLabel.attributedText = attributedText(post.title,
                                                       font: .boldSystemFont(ofSize: 16),
                                                       color: .link,
                                                       extraAttributes: [
                                                        .underlineStyle: NSUnderlineStyle.single.rawValue,
                                                        .underlineColor: UIColor.link
                                                       ])
        postDescriptionLabel.attributedText = attributedText(post.body, font: .systemFont(ofSize: 15))
    }
}
private extension PostsTableViewCell {
    func attributedText(_ text: String,
                        font: UIFont,
                        color: UIColor = .black,
                        extraAttributes: [NSAttributedString.Key: Any] = [:]) -> NSMutableAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: font
        ]
        extraAttributes.forEach {attributes[$0.key] = $0.value}
        return .init(string: text, attributes: attributes)
    }
    
}
