//
//  ViewController1.swift
//  AnimationDemo
//
//  Created by 杨涵 on 15/12/21.
//  Copyright © 2015年 yanghan. All rights reserved.
//

import UIKit

class ViewController1: UIViewController, NSXMLParserDelegate {

    typealias callBackFunc = Void -> Void
    var myFunc = callBackFunc?()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.orangeColor()
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        myFunc?()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
