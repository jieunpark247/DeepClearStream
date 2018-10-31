//
//  ResultViewController.swift
//  DeepClearStream
//
//  Created by PARKHASIK on 2018. 10. 27..
//  Copyright © 2018년 Sungwon Lyu. All rights reserved.
//

import UIKit
import Charts
class ResultViewController: UIViewController {
    //var Double = Array(arrayLiteral:250 , 500, 1000 , 2000, 4000, 8000)
    var pcur1 : Double = 0
    var pcur2 : Double = 0
    var pcur3 : Double = 0
    var pcur4 : Double = 0
    
    
    var numbers : [Double] = []
 
    @IBOutlet weak var msg: UILabel!
    @IBOutlet weak var chtChart: LineChartView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        msg.text="0범위 부근에 가까울 수록 정상 범위 입니다."
        // activity.isHidden = true
        //      updateChart()
        // Do any additional setup after loading the view.
        
        numbers.append(pcur1)
        numbers.append(pcur2)
        numbers.append(pcur3)
        numbers.append(pcur4)
        print(pcur1)
            print(pcur2)
            print(pcur3)
            print(pcur4)
        print(numbers)
        
    }
    
    
    
    func updateChart(){
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        
        
        
        //here is the for loop
        for i in 0..<numbers.count {
            
            let value = ChartDataEntry(x: Double(i), y: numbers[i])
     
            lineChartEntry.append(value)
       
            
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "dB value")
        line1.colors = [NSUIColor.darkGray]
        let data = LineChartData()
        data.addDataSet(line1)

        chtChart.data = data
        chtChart.chartDescription?.text = "진단결과"
        
    }

    

    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
        //        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func applyBtn(_ sender: Any) {
        
      //  activity.isHidden = false
       // activity.startAnimating()
        
        
        
         updateChart()
        
        
       
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
     //   activity.isHidden = true
      //  self.activity.stopAnimating()
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
