//
//  DetailMovieController.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 24/02/23.
//

import UIKit
import RxSwift
import RxCocoa

class DetailMovieController: UIViewController{
    
    // MARK: Properties
    let disposeBag = DisposeBag()
    private let viewModel: ListMovieCellViewModel
    
    private let infoMovieTile = InfoMovieTile()
    private let trailerMovieTile = TrailerMovieTile()
    private let reviewMovieTile = ReviewMovieTile()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var tiles = [UIView]()
    
    // MARK: Lifecycle
    init(viewModel: ListMovieCellViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let trailerMoviewViewModel = TrailerMovieViewModel(movieId: viewModel.movie.id)
        let reviewMovieViewModel = ReviewMovieViewModel(movieId: viewModel.movie.id)
        reviewMovieViewModel.reviewIsEmpty.subscribe { isEmpty in
            if isEmpty{
                self.reviewMovieTile.isHidden = true
            }else{
                self.reviewMovieTile.isHidden = false
            }
        }.disposed(by: disposeBag)
        
        infoMovieTile.viewModel = viewModel
        trailerMovieTile.viewModel = trailerMoviewViewModel
        reviewMovieTile.viewModel = reviewMovieViewModel
        
        tiles.append(infoMovieTile)
        tiles.append(trailerMovieTile)
        tiles.append(reviewMovieTile)
        
        configureUI()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helper
    private func configureUI(){
        view.backgroundColor = .secondarySystemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        for tile in tiles {
            stackView.addArrangedSubview(tile)
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}
