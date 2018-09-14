//
//  ViewController.swift
//  i18n-l10n
//
//  Created by Vilar da Camara Neto on 12/09/18.
//  Copyright © 2018 Vilar da Camara Neto. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let usernameText = username.text, !usernameText.isEmpty else {
            // MARK: 06 alertController
            let alertController = UIAlertController(title: "Invalid login", message:
                "You must provide a login!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

            self.present(alertController, animated: true, completion: nil)
            return false
        }

        return super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
    }
}
