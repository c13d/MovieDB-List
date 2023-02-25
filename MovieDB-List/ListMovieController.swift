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
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        label.text = "No Connection"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Refresh", for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureUI()
        configureRx()
        
        viewModel.fetchGenresAndMovie()
    }
    
    // MARK: - Selector
    @objc func handleRefresh(){
        viewModel.fetchGenresAndMovie()
    }
    
    // MARK: - Helper
    private func configureRx(){
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
        
        viewModel.spinnerIsActive.subscribe {
            print("DEBUG: Spinner is \($0)")
            if $0{
                self.tableView.refreshControl?.beginRefreshing()
            }else{
                self.tableView.refreshControl?.endRefreshing()
            }
        }.disposed(by: disposeBag)
        
        viewModel.showErrorLabel.subscribe{
            if $0{
                self.label.isHidden = false
                self.button.isHidden = false
                self.tableView.isHidden = true
            }else{
                self.label.isHidden = true
                self.button.isHidden = true
                self.tableView.isHidden = false
            }
        }.disposed(by: disposeBag)
    }
    
    private func configureUI() {
        view.addSubview(tableView)
        view.addSubview(label)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 18),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
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

