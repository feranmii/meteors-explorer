//
//  Ext+UIViewController.swift
//  meteor-explorer-app
//
//  Created by Feranmi on 19/09/2021.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, onButtonClick: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: "Retry", style: .default) { _ in
            onButtonClick()
        }
        alertController.addAction(action)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        present(alertController, animated: true, completion: nil)
    }
}
