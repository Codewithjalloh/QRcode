//
//  ViewController.swift
//  QRcode
//
//  Created by wealthyjalloh on 03/07/2016.
//  Copyright © 2016 CWJ. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    // outlet and ins variables
    @IBOutlet var preView: UIView!
    var preViewLayer: AVCaptureVideoPreviewLayer!
    var captureSession: AVCaptureSession!
    var metadataOutput: AVCaptureMetadataOutput!
    var videoDevice: AVCaptureDevice!
    var videoInput: AVCaptureDeviceInput!
    var running = false
    var sendURL: String!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startRunning() {
        if captureSession == nil {
            return
        }
        captureSession.startRunning()
        metadataOutput.metadataObjectTypes = metadataOutput.availableMetadataObjectTypes
        running = true
    }


}

