//
//  ViewController.swift
//  OviaTakeHome
//
//  Created by Jian Ma on 3/6/22.
//

import UIKit

class ViewController: UIViewController {
    
    var textField = UITextField().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
    }
    var searchButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Search", for: .normal)
        $0.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    var tableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .gray
    }
    
    var viewModel: SearchData? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        navigationController?.navigationBar.isTranslucent = false
        tableView.insetsContentViewsToSafeArea = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MovieTableCell.self, forCellReuseIdentifier: "MovieTableCell")
    }
    
    private func setUpUI(){
        view.addSubViews([textField, searchButton, tableView])
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            searchButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor),
            searchButton.heightAnchor.constraint(equalTo: textField.heightAnchor),
            searchButton.topAnchor.constraint(equalTo: textField.topAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func didTapButton() {
        if let text = textField.text, !text.isEmpty {
            Service.getList(quary: textField.text ?? "") { [weak self] (result) in
                switch result {
                case .success(let response):
                        self?.viewModel = response
                case .failure( _):
                    // can add error description to the alert controller
                    DispatchQueue.main.async {
                        self?.presentAlertController()}
                }
            }
        } else {
                self.presentAlertController()
        }
    }
    
    private func presentAlertController() {
        self.present(UIAlertController.custom, animated: false)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.search.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableCell", for: indexPath) as! MovieTableCell
        cell.viewModel = viewModel?.search[indexPath.row]
        return cell
    }
}
