//
//  ScrollViewController.swift
//  SV
//
//  Created by Han, Jelly on 7/7/20.
//  Copyright © 2020 Han, Jelly. All rights reserved.
//
import Foundation
import UIKit

public protocol Storyboarded {
  static func instantiate() -> Self
}

public extension Storyboarded where Self: UIViewController {
  static func instantiate() -> Self {
    let fullName = NSStringFromClass(self)
    let className = fullName.components(separatedBy: ".")[1]
    let storyboardName = className.replacingOccurrences(of: "ViewController", with: "")
    let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: self))
    return storyboard.instantiateViewController(withIdentifier: className) as! Self
  }
}

class ScrollViewController: UIViewController, Storyboarded {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
