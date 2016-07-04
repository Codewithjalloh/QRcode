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
        setupCaptureSession()
        
        if captureSession == nil {
        
        }
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
    
    func stopRunning() {
        captureSession.stopRunning()
        running = false
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.startRunning()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopRunning()
    }
    
    func setupCaptureSession() {
        
    }
    
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        let elemento = metadataObjects.first as? AVMetadataMachineReadableCodeObject
        if (elemento != nil) {
            print(elemento!.stringValue)
            sendURL = elemento!.stringValue
        }
    }

}

