//
//  ErrorView.swift
//  ConcreteChallenge
//
//  Created by Karina on 18/07/22.
//

import UIKit

struct ErrorViewInformation {
    var label: String
    var errorImage: UIImage?
}


class ErrorView: UIView {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let errorImage: UIImageView = {
        let errorImage = UIImageView()
        errorImage.contentMode = .scaleAspectFit
        errorImage.clipsToBounds = true
        errorImage.translatesAutoresizingMaskIntoConstraints = false
        return errorImage
    }()
    
    let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground //maybe change to white
        configureSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        stackView.addArrangedSubview(errorImage)
        stackView.addArrangedSubview(label)
        addSubview(stackView)
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            errorImage.heightAnchor.constraint(equalToConstant: 150),
            
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
    
    func setUpItems(with data: ErrorViewInformation) {
        label.text = data.label
        errorImage.image =  data.errorImage
    }
}
