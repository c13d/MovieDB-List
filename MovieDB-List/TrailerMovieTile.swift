//
//  TrailerMovieTile.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 24/02/23.
//

import UIKit
import RxSwift
import youtube_ios_player_helper
import RxRelay

class TrailerMovieTile: UIView {
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    var viewModel: TrailerMovieViewModel? {
        didSet {
            configure()
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Trailer"
        
        return label
    }()
    
    let collectionView: UICollectionView = {
        let width = UIScreen.main.bounds.width
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: width, height: 200)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(YtPlayerCell.self, forCellWithReuseIdentifier: YtPlayerCell.reuseIdentifier)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cv.widthAnchor.constraint(equalToConstant: width),
            cv.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        return cv
    }()
            
    override var intrinsicContentSize: CGSize{
        return CGSize(width: 100, height: 200)
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - Helpers
    private func addShadow(){
        var shadowLayer: CAShapeLayer!
        let cornerRadius: CGFloat = 6
        let fillColor: UIColor = .white
        shadowLayer = CAShapeLayer()
        
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = fillColor.cgColor
        
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 1
        
        layer.insertSublayer(shadowLayer, at: 0)
    }
    
    private func configureUI(){
        let stack = UIStackView(arrangedSubviews: [titleLabel, collectionView])
        
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 16
        stack.alignment = .leading
        
        addSubview(stack)
        
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    private func configure(){
        guard let viewModel = viewModel else { return }
        
        viewModel.youtubeVideos.asObservable().bind(to: collectionView.rx.items(cellIdentifier: YtPlayerCell.reuseIdentifier, cellType: YtPlayerCell.self)){ index, element, cell in
            if cell.videoId == nil{
                cell.videoId = element
            }
        }.disposed(by: disposeBag)
        
        viewModel.fetchYoutubeVideos()
    }
}
