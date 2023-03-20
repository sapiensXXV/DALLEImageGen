//
//  ViewController.swift
//  DALLEImageGen
//
//  Created by Jaehoon So on 2023/03/20.
//

import UIKit

final class PromptViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "photo")!)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray5
        imageView.layer.cornerRadius = 7
        imageView.tintColor = .gray
        imageView.contentMode = .center
        
        return imageView
    }()
    
    private let promptTextField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let generateButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .tintColor
        button.layer.cornerRadius = 7
        button.setTitle("생성", for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - Configurations
extension PromptViewController {
    
    private func configure() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureNavigation() {
        self.navigationItem.title = "이미지 생성"
    }
    
    private func configureSubviews() {
        view.addSubview(imageView)
        view.addSubview(promptTextField)
        view.addSubview(generateButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(Metric.horizonMargin.rawValue)),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat(Metric.horizonMargin.rawValue)),
            
//            promptTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(Metric.horizonMargin.rawValue)),
//            promptTextField.
            
            generateButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
            generateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6),
            generateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            generateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6),
            generateButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
}

extension PromptViewController {
    enum Metric: Int {
        case horizonMargin = 6
    }
}

