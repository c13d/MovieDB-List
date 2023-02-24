//
//  InfoMovieView.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 24/02/23.
//

import UIKit
import SDWebImage

class InfoMovieView: UIView {
    
    // MARK: - Properties
    let posterImageView: UIImageView = {
        let iv = UIImageView()
        let width: CGFloat = 120
        let height: CGFloat = 160
        
        iv.backgroundColor = .gray
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = width / 8
        NSLayoutConstraint.activate([
            iv.widthAnchor.constraint(equalToConstant: width),
            iv.heightAnchor.constraint(equalToConstant: height)
        ])
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 2
        
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        
        label.text = "Crime, Drama, Comedy, Thriller, Drama"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        let width: CGFloat = 48
        let height: CGFloat = 20
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        label.backgroundColor = .systemGroupedBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.layer.cornerRadius = width / 8
        
        label.text = "R 13+"
        
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: height),
            label.widthAnchor.constraint(equalToConstant: width)
        ])
        
        return label
    }()
    
    override var intrinsicContentSize: CGSize{
        return CGSize(width: 100, height: 200)
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    private func configureUI(){
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, ageLabel, genreLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        
        addSubview(stack)
        addSubview(posterImageView)
        
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            stack.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        ])
    }
}
