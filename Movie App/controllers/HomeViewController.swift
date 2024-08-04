//
//  HomeViewController.swift
//  Movie App
//
//  Created by Trần Quang Tuấn on 2/8/24.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTV = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    let sectionTitle: [String] = ["Trending movie", "Trending TV", "Popular", "Coming soon", "Top rated"]
    
    private let homeTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(homeTable)
        homeTable.dataSource = self
        homeTable.delegate = self
        
        configNavBar()
        
        // add banner
        let poster = HeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeTable.tableHeaderView = poster
    }
    
    func configNavBar() {
        var image = UIImage(named: "app_logo")
        // image will not turn into blue
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "arrow.down"), style: .done, target: self, action: #selector(switchToDownloadVC)),
            UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func switchToDownloadVC() {
        navigationController?.pushViewController(DownloadViewController(), animated: true)
    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // cover whole bounds of screen
        homeTable.frame = view.bounds
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
                return UITableViewCell() }
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.fetchPopularMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(target: titles)
                case .failure(let failure):
                    print(failure)
                }
            }
        case Sections.TrendingTV.rawValue:
            APICaller.shared.fetchTrendingTV { result in
                switch result {
                case .success(let titles):
                    cell.configure(target: titles)
                case .failure(let failure):
                    print(failure)
                }
            }
        case Sections.Popular.rawValue:
            APICaller.shared.fetchPopularMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(target: titles)
                case .failure(let failure):
                    print(failure)
                }
            }
        case Sections.Upcoming.rawValue:
            APICaller.shared.fetchUpComingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(target: titles)
                case .failure(let failure):
                    print(failure)
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.fetchTopRatedMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(target: titles)
                case .failure(let failure):
                    print(failure)
                }
            }
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        var content = header.defaultContentConfiguration()
        content.text = sectionTitle[section]
        content.textProperties.color = .white
        content.textProperties.font = .preferredFont(forTextStyle: .headline)
        header.contentConfiguration = content
    }
    
    // navigation bar will not stick to screen anymore
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
