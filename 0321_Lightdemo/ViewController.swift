//
//  ViewController.swift
//  0321_Lightdemo
//
//  Created by 熊谷晟和 on 2021/03/21.
//


//　初期
//import UIKit
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//
//
//}

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var toggle:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonTapped(_ sender : Any) {
        if(toggle){
            ledFlash(flg: true)
            toggle = false
            
        }
        else{
            ledFlash(flg: false)
            toggle = true
        }
    }
        
    func ledFlash(flg: Bool){
        
        let avDevice = AVCaptureDevice.default(for: AVMediaType.video)!
        
        if avDevice.hasTorch {
            do {
                // torch device lock on
                try avDevice.lockForConfiguration()
                
                if (flg){
                    // flash LED ON
                    avDevice.torchMode = AVCaptureDevice.TorchMode.on
                } else {
                    // flash LED OFF
                    avDevice.torchMode = AVCaptureDevice.TorchMode.off
                }
                
                // torch device unlock
                avDevice.unlockForConfiguration()
                
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
 
    @IBAction func SliderChanged(_ sl: UISlider){
        let level = Float(sl.value)
        if let avDevice = AVCaptureDevice.default(for: AVMediaType.video){
            
            if avDevice.hasTorch {
                do {
                    // torch device lock on
                    try avDevice.lockForConfiguration()
                    
                    if (level > 0.0){
                        do {
                            try avDevice.setTorchModeOn(level: level)
                        } catch {
                            print("error")
                        }
                        
                    } else {
                        // flash LED OFF
                        // 注意しないといけないのは、0.0はエラーになるのでLEDをoffさせます。
                        avDevice.torchMode = AVCaptureDevice.TorchMode.off
                    }
                    // torch device unlock
                    avDevice.unlockForConfiguration()
                    
                } catch {
                    print("Torch could not be used")
                }
            } else {
                print("Torch is not available")
            }
        }
        else{
            // no support
        }
    }
}

