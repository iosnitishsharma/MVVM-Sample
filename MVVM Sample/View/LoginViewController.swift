//
//  LoginViewController.swift
//  MVVM Sample
//
//  Created by Juani on 10/06/2016.
//  Copyright © 2016 Juani. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

class LoginViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var errorMessageLabel: UILabel!
    @IBOutlet var loginButton: UIButton!
    
    var loginAction:CocoaAction!

    var viewModel = LoginViewModel(authService: RemoteAuthService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewModel.userName <~ usernameTextField.rac_textSignalProducer()
        viewModel.password <~ passwordTextField.rac_textSignalProducer()
        
        viewModel.errorMessage.producer.observeOn(UIScheduler()).startWithNext { [weak self] (msg) in
            self?.errorMessageLabel.text = msg
        }
        
        viewModel.inputIsValid.producer
            .observeOn(UIScheduler())
            .startWithNext({ [weak self] inputIsValid in
                self?.loginButton.enabled = inputIsValid
                })
        

        loginAction = CocoaAction(viewModel.loginAction, input: ())
        loginButton.addTarget(loginAction, action: CocoaAction.selector, forControlEvents: .TouchUpInside)
        viewModel.loginAction.events.observeOn(UIScheduler()).observeNext({ [weak self] event in
            switch event {
            case let .Next(success):
                if success {
                    self?.performSegueWithIdentifier("showWelcome", sender: self)
                }
            default:
                return
            }
            })
   
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? HomeVC
            where segue.identifier == "showWelcome" {
            vc.viewModel = self.viewModel.viewModeForHomeVC()
        }
    }
    

}

