//
//  ReviewCell.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 24/02/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ReviewCell: UITableViewCell {
    
    // MARK: - Properties
    var viewModel: ReviewCellViewModel? {
        didSet{
            configure()
        }
    }
    
    var disposeBag = DisposeBag()
    static let reuseIdentifier = "ReviewCell"
    static let rowHeight: CGFloat = 50
    
    let profilePictureView: ProfilePictureView = {
        let view = ProfilePictureView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateAddedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureUI()
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    func configure(){
        guard let viewModel = viewModel else { return }
        
        nameLabel.text = viewModel.review.author
        reviewLabel.text = viewModel.review.content
        dateAddedLabel.text = viewModel.relativeDate
        profilePictureView.text =  viewModel.profilePictureText
    }
    
    private func configureUI(){
        
        addSubview(profilePictureView)
        addSubview(stackView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(reviewLabel)
        stackView.addArrangedSubview(dateAddedLabel)
        
        NSLayoutConstraint.activate([
            profilePictureView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            profilePictureView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            profilePictureView.heightAnchor.constraint(equalToConstant: 50),
            profilePictureView.widthAnchor.constraint(equalToConstant: 50),
            
            stackView.topAnchor.constraint(equalTo: profilePictureView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: profilePictureView.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}

