//
//  oneViewController.swift
//  DeepClearStream
//
//  Created by PARKHASIK on 2018. 10. 27..
//  Copyright © 2018년 Sungwon Lyu. All rights reserved.
//

import UIKit
import fluid_slider
class oneViewController: UIViewController {
  
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var slider2: UISlider!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var slider3: UISlider!
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var slider4: UISlider!
    @IBOutlet weak var label4: UILabel!
   
 //   var numbers = [1, 2, 3, 4, 5, 6, 7] //Add your values here
    var oldIndex = 0
    var current1: Double = 0
     var current2: Double = 0
     var current3: Double = 0
     var current4: Double = 0
    @IBAction func sliderChange1(_ sender: UISlider) {
        current1 = Double(Int(sender.value))
        label1.text = "\(current1)"
        
    }
    @IBAction func sliderChange2(_ sender: UISlider) {
        current2 = Double(Int(sender.value))
        label2.text = "\(current2)"
    }
    @IBAction func sliderChange3(_ sender: UISlider) {
        current3 = Double(Int(sender.value))
        label3.text = "\(current3)"
    }
    @IBAction func sliderChange4(_ sender: UISlider) {
        current4 = Double(Int(sender.value))
        label4.text = "\(current4)"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider1.maximumValue = 80
        slider2.maximumValue = 80
        slider3.maximumValue = 80
        slider4.maximumValue = 80
    }
    
        
 
    
    @IBAction func oneBtn(_ sender: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier:"ResultVC") as? ResultViewController else{
            return
        }
        
        uvc.pcur1 = current1
        uvc.pcur2 = current2
        uvc.pcur3 = current3
        uvc.pcur4 = current4
        
        self.present(uvc,animated: true)
        //self.navigationController?.pushViewController(uvc, animated: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func back(_ sender: Any) {
       self.presentingViewController?.dismiss(animated: true)
//        self.navigationController?.popViewController(animated: true)
    }
}
