//
//  YtPlayerCell.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 25/02/23.
//

import UIKit
import youtube_ios_player_helper
import RxSwift
class YtPlayerCell: UICollectionViewCell {
        
    // MARK: - Properties
    var videoId: Video? {
        didSet{
            configure()
        }
    }
    
    var disposeBag = DisposeBag()
    static let reuseIdentifier = "YtPlayerCell"
    override var intrinsicContentSize: CGSize{
        return CGSize(width: 100, height: 200)
    }
    
    let youtubePlayer: YTPlayerView = {
        let player = YTPlayerView()
        let width = UIScreen.main.bounds.width
        
        player.translatesAutoresizingMaskIntoConstraints = false
        player.heightAnchor.constraint(equalToConstant: 200).isActive = true
        player.widthAnchor.constraint(equalToConstant: width - 16).isActive = true
        
//        player.backgroundColor = .gray
        return player
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect){
        super.init(frame: .zero)
        configureUI()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    private func configureUI(){
        contentView.addSubview(youtubePlayer)
        
        NSLayoutConstraint.activate([
            youtubePlayer.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            youtubePlayer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            youtubePlayer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            youtubePlayer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
        
    }
    
    private func configure(){
        guard let videoId = self.videoId else { return }
        DispatchQueue.main.async { [weak self] in
            self?.youtubePlayer.load(withVideoId: videoId.key)
        }
    }
}
