//
//  ViewController.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 23/02/23.
//

import UIKit
import RxSwift
import RxCocoa

class ListMovieController: UIViewController {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    let viewModel = ListMovieViewModel()
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        tv.estimatedRowHeight = 160
        tv.register(ListMovieCell.self, forCellReuseIdentifier: ListMovieCell.reuseIdentifier)
        tv.dataSource = nil
        return tv
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureUI()
        
        bindTableViewRx()        
    }
    
    // MARK: - Helper
    private func bindTableViewRx(){
        viewModel.movies.asObservable()
            .bind(to: self.tableView.rx
                .items(cellIdentifier: ListMovieCell.reuseIdentifier, cellType: ListMovieCell.self))
        {   index, element, cell in
            cell.selectionStyle = .none
            cell.viewModel = ListMovieCellViewModel(movie: element, allGenres: self.viewModel.genres)
            
        }.disposed(by: disposeBag)
            
        tableView.rx.modelSelected(TopRatedResult.self).subscribe { model in
            print(model)
            let nextVC = DetailMovieController(viewModel: ListMovieCellViewModel(movie: model, allGenres: self.viewModel.genres))
            self.navigationController?.pushViewController(nextVC, animated: true)
        }.disposed(by: disposeBag)

        tableView.rx.didScroll.subscribe{ [weak self] _ in
            guard let self = self else {return}
            let offSetY = self.tableView.contentOffset.y
            let contentHeight = self.tableView.contentSize.height

            if contentHeight == 0 { return}


            if offSetY > (contentHeight - self.tableView.frame.size.height - 100) {
                self.viewModel.fetchMoreMovie()
            }
        }.disposed(by: disposeBag)
    }
    
    private func configureUI() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
    
    private func configureNavigationBar(){
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .secondarySystemBackground

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        
        navigationItem.title = "List Movie"
    }
}

