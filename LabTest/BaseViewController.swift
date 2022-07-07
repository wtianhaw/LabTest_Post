//
//  BaseViewController.swift
//  LabTest
//
//  Created by Wong Tian Haw on 06/07/2022.
//

import UIKit
import Combine

class BaseViewController: UIViewController {

    var cancellables: [AnyCancellable] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
}
