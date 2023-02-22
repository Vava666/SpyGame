//
//  MainViewController.swift
//  SpyGame
//
//  Created by Artem Vavilov on 18.02.2023.
//

import UIKit

protocol MainViewControllerProtocol: AnyObject {
    func clearLabels()
}

class MainViewController: ViewController {
    
    var presenter: MainViewPresenterProtocol?
    private let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        addSubviews()
        setupConstraints()
        setupViews()
        setupObservers()
    }
    
    private func addSubviews() {
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupViews() {
        mainView.buttonAction = { [weak self] in
            self?.presenter?.startButtonPressed(players: $0, spies: $1)
        }
        
        mainView.showAllert = { [weak self] in
            self?.showAlert(message: $0)
        }
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue, view.frame.origin.y == 0 {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            view.frame.origin.y -= keyboardHeight
        }
    }
    
    @objc
    private func keyboardWillHide() {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = .zero
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension MainViewController: MainViewControllerProtocol {
    func clearLabels() {
        mainView.clearLabels()
    }
}
