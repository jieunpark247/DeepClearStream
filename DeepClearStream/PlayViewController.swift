//
//  PlayViewController.swift
//  DeepClearStream
//
//  Created by 류성원 on 2018. 10. 6..
//  Copyright © 2018년 Sungwon Lyu. All rights reserved.
//

import UIKit
import AVFoundation
import Vision
import CoreML

class PlayViewController: UIViewController  {
    @IBAction func back(_ sender: Any) {
       
       self.presentingViewController?.dismiss(animated: true)
       
    }
    var engine = AVAudioEngine() //오디오 신호를 생성 및 처리하고 오디오 입출력을 수행하는 데 사용되는 연결된 오디오 노드 객체 그룹
    let player = AVAudioPlayerNode() //오디오 파일의 버퍼 재생하는 클래스
    let audioSession = AVAudioSession.sharedInstance() //앱에서 오디오를 어떻게 사용할 것인지 시스템과 통신하는 매개 객체 (공유 오디오 세션 인스턴스를 리턴)
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
   let bSize : AVAudioFrameCount = 4096
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let audioModel = SimpleModel() //coreML모델
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord,  mode:AVAudioSession.Mode.measurement, options:[AVAudioSession.CategoryOptions.allowBluetoothA2DP]) //오디오 세션 카테고리, 모드 및 원하는 옵션을 설정
            try audioSession.setActive(true) //지정된 옵션을 사용하여 앱의 오디오 세션을 활성화하거나 비활성화
        } catch {
            fatalError("\(error)")
        }
        
        let input = engine.inputNode //오디오 엔진의 싱글 톤 입력 오디오 노드
    
        engine.attach(player) //새 오디오 노드를 오디오 엔진에 연결
        
        let bus = 0
        let inputFormat = input.inputFormat(forBus: bus) //지정된 버스의 입력 형식을 리턴
        engine.connect(player, to: engine.mainMixerNode, format: inputFormat)

        
        //버스의 오디오 탭을 설치하여 노드의 출력을 기록, 모니터링 및 관찰
        // 4800?
        
     
        input.installTap(onBus: bus, bufferSize: 4800, format: inputFormat) { (buffer, time) -> Void in
            print("buffer: \(buffer)", "frameLength: \(buffer.frameLength)")
          //  self.player.scheduleBuffer(buffer)
            
          //  let arraySize = bufferSize
       
            let arraySize = Int(buffer.frameLength)
            let samples = Array(UnsafeBufferPointer(start: buffer.floatChannelData![0], count: arraySize))
            guard let mlMultiArray = try? MLMultiArray(shape:[4800], dataType:MLMultiArrayDataType.double) else {
                fatalError("Unexpected runtime error. MLMultiArray")
            }
            
            //sample array 를 mlmultiArray에 넣어줌
            //NSNumber?
           
            for (index, element) in samples.enumerated() {
                mlMultiArray[index] = NSNumber(floatLiteral: Double(element))
            }
            
            let audioInput = SimpleModelInput(input__0: mlMultiArray)
            let options = MLPredictionOptions() //?
//            options.usesCPUOnly = true
            guard let results = try? audioModel.prediction(input: audioInput, options: options) else{
                fatalError("prediction fail")
            }
           
            let resultAudio = results.mult2__0
            let arraySize2 = resultAudio.count
            let doublePtr = resultAudio.dataPointer.bindMemory(to: Double.self, capacity: arraySize)
            let show = Array(UnsafeBufferPointer(start: doublePtr, count: arraySize2))
            let show2 = show.floatArray
            
            let outputArray = self.doubleArrayToNSData(array: show2)
            let pcmBuffer = self.toPCMBuffer(data: outputArray)
            print("pcm: \(pcmBuffer)", "frameLength: \(pcmBuffer.frameLength)")
            let samples2 = Array(UnsafeBufferPointer(start: pcmBuffer.floatChannelData![0], count:arraySize))
            print("count: \(samples2.count)")
            self.player.scheduleBuffer(pcmBuffer)
        }
        
        
        
        
    }

//    func handler(request: VNRequest, error: Error?) {
//        if let theError = error {
//            print("Error: \(theError.localizedDescription)")
//            return
//        }
//        guard let results = request.results else {
//            print("No results")
//            return
//        }
//        print(results)
//    }

    func toNSData(PCMBuffer: AVAudioPCMBuffer) -> NSData {
        let channels = UnsafeBufferPointer(start: PCMBuffer.floatChannelData, count: 1)
        let ch0Data = NSData(bytes: channels[0], length:Int(PCMBuffer.frameCapacity * PCMBuffer.format.streamDescription.pointee.mBytesPerFrame))
        return ch0Data
    }

    func toPCMBuffer(data: NSData) -> AVAudioPCMBuffer {
        let audioFormat = AVAudioFormat(commonFormat: AVAudioCommonFormat.pcmFormatFloat32, sampleRate: 4800, channels: 1, interleaved: false)  // given NSData audio format
        let PCMBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat!, frameCapacity: UInt32(data.length) / audioFormat!.streamDescription.pointee.mBytesPerFrame)
        PCMBuffer!.frameLength = PCMBuffer!.frameCapacity
        let channels = UnsafeBufferPointer(start: PCMBuffer!.floatChannelData, count: Int(PCMBuffer!.format.channelCount))
        data.getBytes(UnsafeMutableRawPointer(channels[0]) , length: data.length)
        return PCMBuffer!
    }

    func doubleArrayToNSData(array: [Float32]) -> NSData {
        var float_var: Float32
        var data_var: Data
        let data = NSMutableData()
        for float in array {
            float_var = float
            data_var = Data(buffer: UnsafeBufferPointer(start: &float_var, count: 1))
            let ns = NSData(data: data_var)
            data.append(ns as Data)
        }
        return data
    }
    
    @IBAction func recordButtonPressed(_ sender: UIButton) {
        do{
            try engine.start()
        } catch {
            fatalError("\(error)")
        }
        player.play()
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        engine.stop()
        player.stop()
    }
}
//
//extension Data {
//
//    init<T>(from value: T) {
//        var value = value
//        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
//    }
//
//    func to<T>(type: T.Type) -> T {
//        return self.withUnsafeBytes { $0.pointee }
//    }
//}

extension Collection where Iterator.Element == Double {
//    var doubleArray: [Double] {
//        return compactMap{ Double($0) }
//    }
    var floatArray: [Float] {
        return compactMap{ Float($0) }
    }
    
    
    
}
