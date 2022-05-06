//
//  ViewController.swift
//  IosFlutterChat
//
//  Created by Abel Rodriguez Medel on 7/2/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    private let myFlutterViewController : MyFlutterViewController = MyFlutterViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.layer.borderWidth = 1
        self.textView.layer.cornerRadius = 4
        
        self.myFlutterViewController.setupPlatformChannels(textView: self.textView)
    }


    @IBAction func send(_ sender: Any) {
        self.myFlutterViewController.eventChannelSink!(self.textView.text)
        present(self.myFlutterViewController, animated: true, completion: nil)
    }
}

