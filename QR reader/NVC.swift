//
//  NVC.swift
//  QR reader
//
//  Created by Carlos Brito on 26/01/16.
//  Copyright © 2016 Carlos Brito. All rights reserved.
//

import UIKit

class NVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let origen = sender as! ViewController
        let vc = segue.destinationViewController as! VC
        origen.sesion?.stopRunning()
        
        vc.urls = origen.urls
        
        
    }

}
