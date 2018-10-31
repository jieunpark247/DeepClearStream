//
//  SelectViewController.swift
//  DeepClearStream
//
//  Created by PARKHASIK on 2018. 10. 27..
//  Copyright © 2018년 Sungwon Lyu. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func testBtn(_ sender: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier:"popupVC")else{
            return
        }
                self.navigationController?.pushViewController(uvc, animated: true)
    }
    
    @IBAction func playBtn(_ sender: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier:"playVC")else{
            return
        }
        self.navigationController?.pushViewController(uvc, animated: true)
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
