//
//  MovieListViewController.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 5/6/24.
//

import UIKit

class MovieListViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .plain)

    var movieModels: [MovieModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            movieModels = await MovieModel.fetchMovie()
            self.tableView.reloadData()
        }
        setUI()
        register()
    }

    private func setUI() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func register() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(
            MovieCell.self,
            forCellReuseIdentifier: MovieCell.identifier
        )
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        cell.bindData(movieModels[indexPath.row])
        return cell
    }
}
