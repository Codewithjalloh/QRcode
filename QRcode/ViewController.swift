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
            let alert = UIAlertController(title: "Camera required", message: "this device has no camera. This is an iOS Simulator", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Got it", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: false, completion: nil)
        
        } else {
            preViewLayer.frame = preView.bounds
            preView.layer.addSublayer(preViewLayer)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "startRunning:", name: UIApplicationDidEnterBackgroundNotification, object: nil)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "stopRunning:", name: UIApplicationDidEnterBackgroundNotification, object: nil)
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
    
    // setupCapSession function
    func setupCaptureSession() {
        if(captureSession != nil) {
            return
        }
        videoDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        if (videoDevice == nil) {
            print("No camera on this device")
            return
        }
        
        captureSession = AVCaptureSession()
        videoInput = (try! AVCaptureDeviceInput(device: videoDevice) as AVCaptureDeviceInput)
        
        if(captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        }
        preViewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        preViewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        metadataOutput = AVCaptureMetadataOutput()
        
        let metadataQueue = dispatch_queue_create("com.example.QRCode.metadata", nil)
        metadataOutput.setMetadataObjectsDelegate(self, queue: metadataQueue)
        
        if(captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
        }
        
    }
    
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        let elemento = metadataObjects.first as? AVMetadataMachineReadableCodeObject
        if (elemento != nil) {
            print(elemento!.stringValue)
            sendURL = elemento!.stringValue
        }
    }

}

