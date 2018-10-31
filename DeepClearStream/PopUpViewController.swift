//
//  PopUpViewController.swift
//  DeepClearStream
//
//  Created by PARKHASIK on 2018. 10. 27..
//  Copyright © 2018년 Sungwon Lyu. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet var message: UILabel!

    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        
        message.numberOfLines = 0;
  
        
        message.text = "*주의사항*\n이 테스트는 전문적인 청력 테스트의 결과가 아닐 수 있습니다. 청력손상을 우려한다면 즉시 전문가와 상담해주세요"
        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopup(_ sender: UIButton) {
        //dismiss(animated: true, completion: nil)
        
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier:"oneVC")else{
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
