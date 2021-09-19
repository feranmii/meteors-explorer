//
//  MeteorsViewController.swift
//  meteor-explorer-app
//
//  Created by Feranmi on 17/09/2021.
//

import UIKit

final class MeteorsViewController: UIViewController {
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    let viewModel = MeteorsViewModel()
    let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = .appGreen
        return refresh
    }()

    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .appGreen
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchData()
    }
    
    private func setupViews() {
        tableView.accessibilityIdentifier = "meteors-tableView"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MeteorTableViewCell.self, forCellReuseIdentifier: MeteorTableViewCell.identifier)
        tableView.refreshControl = refreshControl
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.accessibilityIdentifier = "meteors-sort-control"
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        loadingIndicator.startAnimating()
    }
    
    private func updateUI() {
        tableView.reloadData()
    }
  
    @objc func fetchData() {
        toggleUserInteraction(false)
        viewModel.fetchMeteors(onSuccess: {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.updateUI()
                self.refreshControl.endRefreshing()
                if self.loadingIndicator.isAnimating {
                    self.loadingIndicator.stopAnimating()
                }
                self.toggleUserInteraction(true)
            }
        }, onFailure: { error in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.showAlert(title: "Error", message: error) {
                    self.fetchData()
                }
            }
        })
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        loadingIndicator.startAnimating()
        if sender.selectedSegmentIndex == 0 {
            viewModel.endpoint = .getMeteorsByDate()
            fetchData()
        }
        else {
            viewModel.endpoint = .getMeteorsBySize()
            fetchData()
        }
    }
    
    func toggleUserInteraction(_ state: Bool) {
        segmentedControl.isUserInteractionEnabled = state
        tableView.isUserInteractionEnabled = state
    }
}

extension MeteorsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.meteors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MeteorTableViewCell.identifier, for: indexPath) as! MeteorTableViewCell
        
        let meteor = viewModel.meteors[indexPath.row]
        cell.bind(data: meteor)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard!.instantiateViewController(withIdentifier: String(describing: MeteorMapViewController.self)) as! MeteorMapViewController
        vc.modalPresentationStyle = .fullScreen
        vc.meteor = viewModel.meteors[indexPath.row]
        present(vc, animated: true)
    }
}
