//
//  FavoritesViewController.swift
//  meteor-explorer-app
//
//  Created by Feranmi on 17/09/2021.
//

import UIKit

final class FavoritesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    let viewModel = FavoritesViewModel()
    let notificationCenter = NotificationCenter.default

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MeteorTableViewCell.self, forCellReuseIdentifier: MeteorTableViewCell.identifier)

        notificationCenter.addObserver(self, selector: #selector(onMeteorFavorited), name: .onMeteorFavourited, object: nil)
    }

    @objc private func onMeteorFavorited() {
        viewModel.getFavorites()
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MeteorTableViewCell.identifier, for: indexPath) as! MeteorTableViewCell
        let meteor = viewModel.favorites[indexPath.row]
        cell.bind(data: meteor)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard!.instantiateViewController(withIdentifier: String(describing: MeteorMapViewController.self)) as! MeteorMapViewController
        vc.modalPresentationStyle = .fullScreen
        vc.meteor = viewModel.favorites[indexPath.row]
        present(vc, animated: true)
    }
}
