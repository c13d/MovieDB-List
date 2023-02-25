//
//  ListMovieCell.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 23/02/23.
//

import UIKit
import RxSwift
import SDWebImage

class ListMovieCell: UITableViewCell {
    // MARK: - Properties
    static let reuseIdentifier = "MovieCell"

    var disposeBag = DisposeBag()
    var viewModel: ListMovieCellViewModel? {
        didSet {
            configure()
        }
    }
    
    let infoMovieView: InfoMovieView = {
        let view = InfoMovieView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override var intrinsicContentSize: CGSize{
        return CGSize(width: 100, height: 50)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    private func configureUI(){
        selectionStyle = .none
        
        addSubview(infoMovieView)
        
        NSLayoutConstraint.activate([
            infoMovieView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            infoMovieView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            infoMovieView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            infoMovieView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    private func configure(){
        guard let viewModel = viewModel else { return }
        let transformer = SDImageResizingTransformer(size: CGSize(width: 120, height: 160), scaleMode: .aspectFill)
        
        infoMovieView.titleLabel.text = viewModel.title
        infoMovieView.genreLabel.text = viewModel.genres
        infoMovieView.ageLabel.text = viewModel.ages
        infoMovieView.posterImageView.sd_setImage(with: URL(string: viewModel.imageUrl), placeholderImage: nil, context: [.imageTransformer: transformer])
        
    }
}
