//
//  Ext+UIViewController.swift
//  meteor-explorer-app
//
//  Created by Feranmi on 19/09/2021.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, buttonMessage: String? = "OK", onButtonClick: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        
        let action = UIAlertAction(title: buttonMessage, style: .default) { _ in
            if onButtonClick != nil {
                onButtonClick?()
            }
            else {
                alertController.dismiss(animated: true)
            }
            
        }
        alertController.addAction(action)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        present(alertController, animated: true, completion: nil)
    }
}
