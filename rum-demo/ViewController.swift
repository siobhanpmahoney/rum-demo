//
//  ViewController.swift
//  rum-demo
//
//  Created by Adam Kaczmarek on 1/11/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    var count: Int = 0
    
    @IBAction func didTapButton() {
        present(BlueViewController(), animated: true)
    }
    
    @IBAction func didIncrementButton() {
        count += 1
        counterOutput.text = String(count)
    }
    
    @IBOutlet weak var counterOutput: UILabel!
    
    @IBAction func didErrorButton() {
        print("Something went wrong....")
    }

}

class BlueViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
}
