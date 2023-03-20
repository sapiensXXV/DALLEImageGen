//
//  ViewController.swift
//  DALLEImageGen
//
//  Created by Jaehoon So on 2023/03/20.
//

import UIKit

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
    
    private let openAIViewModel: OpenAIViewModel = OpenAIViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        openAIViewModel.setup()
    }
}

// MARK: - Configurations
extension PromptViewController {
    
    private func configure() {
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
            
        ])
    }
    
    private func configureActions() {
        generateButton.addAction(UIAction(handler: { action in
            Task {
                print("Activate")
                guard let text = self.promptTextField.text,
                      let result = await self.openAIViewModel.generateImage(prompt: text) else { return }
                self.imageView.image = result
            }
        }), for: .touchUpInside)
    }
}


extension PromptViewController {
    enum Metric: Int {
        case horizonMargin = 8
    }
}

