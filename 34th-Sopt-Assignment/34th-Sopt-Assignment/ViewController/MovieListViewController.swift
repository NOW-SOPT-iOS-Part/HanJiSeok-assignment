//
//  MovieListViewController.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 5/6/24.
//

import UIKit

class MovieListViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await print(MovieModel.fetchMovie())
        }
    }
}

