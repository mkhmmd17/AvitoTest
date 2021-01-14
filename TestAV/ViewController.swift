//
//  ViewController.swift
//  TestAV
//
//  Created by muslim on 14.01.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()§
        // Do any additional setup after loading the view.
        
        let path = Bundle.main.path(forResource: "result", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        do  {
            let data = try Data(contentsOf: url)
            let results = try JSONDecoder().decode(Main.self, from: data)
            print (results)
        } catch {}
    }

}

