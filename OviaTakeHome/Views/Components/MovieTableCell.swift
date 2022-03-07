//
//  MovieTableCell.swift
//  OviaTakeHome
//
//  Created by Jian Ma on 3/6/22.
//

import UIKit

class MovieTableCell: UITableViewCell {
    
    var titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
    }
    
    var ratingLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .blue
    }
    
    var posterImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var viewModel: Search? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.titleLabel.text = self?.viewModel?.title
            }
            if let id = viewModel?.imdbID {
                Service.getRating(with: id) { [weak self] (result) in
                    switch result {
                    case .success(let response):
                        DispatchQueue.main.async { [weak self] in
                            self?.ratingLabel.text = response.imdbRating.getStars()
                            self?.ratingLabel.accessibilityLabel = response.imdbRating.getAccessibilityStars()
                        }
                    case .failure( let err):
                        print("\(err)")
                    }
                }
            }
            if let poster = viewModel?.poster, let url = URL(string: poster) {
                URLSession.shared.dataTask(with: url, completionHandler: { (data, res, err) in
                    if let data = data {
                        DispatchQueue.main.async { [weak self] in
                            self?.posterImageView.image = UIImage(data: data)
                        }
                    }
                }).resume()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .purple
        setupUI()
    }
    
    private func setupUI() {
        addSubViews([titleLabel,ratingLabel, posterImageView])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            posterImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.heightAnchor.constraint(equalTo: heightAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("fatal message")
    }
}
