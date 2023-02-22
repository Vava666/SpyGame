//
//  FinalViewController.swift
//  SpyGame
//
//  Created by Artem Vavilov on 21.02.2023.
//

import UIKit

protocol FinalViewControllerDelegate: AnyObject {
    func getSpyName() -> String
}

protocol FinalViewControllerProtocol: AnyObject {
    
}

final class FinalViewController: UIViewController {
    var presenter: FinalViewPresenterProtocol?
    private let finalView = FinalView()
    
    override func loadView() {
        super.loadView()
        setup()
        configureNavigationBarButtonItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finalView.configure(with: 90)
    }
    
    private func setup() {
        view.addSubview(finalView)
        finalView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            finalView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            finalView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            finalView.topAnchor.constraint(equalTo: view.topAnchor),
            finalView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        finalView.delegate = self
    }
    
    private func configureNavigationBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetTapped))
    }
    
    @objc
    private func resetTapped() {
        presenter?.popToRoot()
    }
}

extension FinalViewController: FinalViewControllerProtocol {
    
}

extension FinalViewController: FinalViewControllerDelegate {
    func getSpyName() -> String {
        if let spies = presenter?.getSpyName() {
            return spies
        } else {
            return ""
        }
    }
}
