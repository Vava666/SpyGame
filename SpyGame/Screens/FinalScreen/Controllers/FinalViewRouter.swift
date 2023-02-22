//
//  FinalViewRouter.swift
//  SpyGame
//
//  Created by Artem Vavilov on 22.02.2023.
//

import UIKit

protocol FinalViewRouterProtocol: AnyObject {
    func popOutToRootController()
}

final class FinalViewRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension FinalViewRouter: FinalViewRouterProtocol {
    func popOutToRootController() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
