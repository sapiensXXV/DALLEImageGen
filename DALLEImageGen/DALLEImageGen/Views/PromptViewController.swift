//
//  ViewController.swift
//  DALLEImageGen
//
//  Created by Jaehoon So on 2023/03/20.
//

import UIKit
import OpenAIKit

// MARK: - Properties and LifeCycle
final class PromptViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "photo")!)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray5
        imageView.layer.cornerRadius = 7
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let promptTextField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "이곳에 입력하세요 ..."
        
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
    
    private let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.isHidden = true
        indicatorView.style = .large
        indicatorView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        indicatorView.layer.cornerRadius = 8
        
        return indicatorView
    }()
    
    private let openAIViewModel: OpenAIViewModel = OpenAIViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        openAIViewModel.delegate = self
        openAIViewModel.setup()
    }
}

// MARK: - Functions
extension PromptViewController {
    
    private func configure() {
        configureNavigation()
        configureSubviews()
        configureConstraints()
        configureActions()
    }
    
    private func configureNavigation() {
        self.navigationItem.title = "DALLE-E 이미지 생성봇"
    }
    
    private func configureSubviews() {
        view.addSubview(imageView)
        view.addSubview(promptTextField)
        view.addSubview(generateButton)
        view.addSubview(indicatorView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(Metric.horizonMargin.rawValue)),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat(Metric.horizonMargin.rawValue)),
            
            promptTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            promptTextField.centerYAnchor.constraint(equalTo: generateButton.centerYAnchor),
            promptTextField.heightAnchor.constraint(equalToConstant: 60),
            
            generateButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            generateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6),
            generateButton.leadingAnchor.constraint(equalTo: promptTextField.trailingAnchor, constant: 8),
            generateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            generateButton.heightAnchor.constraint(equalToConstant: 40),
            generateButton.widthAnchor.constraint(equalToConstant: 60),
            
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicatorView.widthAnchor.constraint(equalToConstant: 50),
            indicatorView.heightAnchor.constraint(equalToConstant: 50),
            
            
        ])
    }
    
    private func configureActions() {
        generateButton.addAction(UIAction(handler: { action in
            self.activateIndicator()
            guard let text = self.promptTextField.text else { return }
            self.openAIViewModel.activate(.generateImage(text))
        }), for: .touchUpInside)
    }
    
    private func activateIndicator() {
        indicatorView.isHidden = true
        indicatorView.startAnimating()
    }
    
    private func suspendIndicator() {
        indicatorView.isHidden = false
        indicatorView.stopAnimating()
    }
}

// MARK: - OpenAIVIewModelDelegate
extension PromptViewController: OpenAIViewModelDelegate {
    func openAIErrorOccur(with errorResponse: OpenAIErrorResponse) {
        print(#function)
        suspendIndicator()
        let errorType = errorResponse.error.type
        print(errorType)
        
        
    }
    
    func openAIResultImageDidChange(to image: UIImage) {
        print(#function)
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = image
            self?.suspendIndicator()
        }
    }
    
    
}

extension PromptViewController {
    enum Metric: Int {
        case horizonMargin = 8
    }
}

