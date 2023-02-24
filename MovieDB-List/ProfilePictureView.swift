//
//  ProfilePictureView.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 24/02/23.
//

import UIKit

class ProfilePictureView: UIView{
    
    // MARK: - Properties
    let profilePictureNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override var intrinsicContentSize: CGSize{
        return CGSize(width: 30, height: 30)
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        configureUI()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = layer.bounds.width / 2
        clipsToBounds = true
    }
    
    // MARK: - Helper
    
    private func configureUI(){
        addSubview(profilePictureNameLabel)
        NSLayoutConstraint.activate([
            profilePictureNameLabel.topAnchor.constraint(equalTo: topAnchor),
            profilePictureNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            profilePictureNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            profilePictureNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(text: String){
        profilePictureNameLabel.text = text
    }
}
