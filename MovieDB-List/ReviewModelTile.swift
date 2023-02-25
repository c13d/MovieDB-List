//
//  ReviewModelTile.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 24/02/23.
//

import UIKit
import RxSwift

class ReviewMovieTile: UIView {

    // MARK: - Properties
    let disposeBag = DisposeBag()
    var viewModel: ReviewMovieViewModel? {
        didSet {
            configure()
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Review"
        
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        let height = UIScreen.main.bounds.height
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalToConstant: height - 200)
        ])
        
        tableView.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.reuseIdentifier)
        tableView.estimatedRowHeight = ReviewCell.rowHeight
        
        return tableView
    }()
    
    lazy var stack: UIStackView = {
        let height = UIScreen.main.bounds.height
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, tableView])
        stack.spacing = 16
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.heightAnchor.constraint(equalToConstant: height - 170).isActive = true
        
        return stack
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
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private func configure(){
        guard let viewModel = viewModel else { return }
        
        viewModel.reviews.asObservable().bind(to: tableView.rx.items(cellIdentifier: ReviewCell.reuseIdentifier, cellType: ReviewCell.self)){ index, element, cell in
            cell.viewModel = ReviewCellViewModel(review: element)
        }.disposed(by: disposeBag)
        
        viewModel.fetchReviews()
    }
}
