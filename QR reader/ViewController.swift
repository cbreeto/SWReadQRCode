//
//  ViewController.swift
//  QR reader
//
//  Created by Carlos Brito on 26/01/16.
//  Copyright © 2016 Carlos Brito. All rights reserved.
//

import UIKit
import AVFoundation



class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var sesion : AVCaptureSession?
    var capa : AVCaptureVideoPreviewLayer?
    var marcoQR : UIView?
    var urls : String?
    
    override func viewWillAppear(animated: Bool) {
        
        sesion?.startRunning()
        marcoQR?.frame = CGRectZero
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "QR Principal"
        let dispositivo = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do {
            let entrada = try AVCaptureDeviceInput(device: dispositivo)
            sesion = AVCaptureSession()
            sesion?.addInput(entrada)
            
            let metaDatos = AVCaptureMetadataOutput()
            sesion?.addOutput(metaDatos)
            
            metaDatos.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            
            metaDatos.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            
            capa = AVCaptureVideoPreviewLayer(session: sesion!)
            capa?.videoGravity = AVLayerVideoGravityResizeAspectFill
            capa?.frame = view.layer.bounds
            view.layer.addSublayer(capa!)
            
            marcoQR = UIView()
            marcoQR?.layer.borderWidth = 3
            marcoQR?.layer.borderColor = UIColor.redColor().CGColor
            view.addSubview(marcoQR!)
            
            sesion?.startRunning()
        }
        catch {
        }
        
    }

//delegado
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        marcoQR?.frame = CGRectZero
        if metadataObjects == nil || metadataObjects.count == 0 {
            return
        }
        let objMetadato = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if objMetadato.type == AVMetadataObjectTypeQRCode {
            let objBordes = capa?.transformedMetadataObjectForMetadataObject(
            objMetadato as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            
            marcoQR?.frame = objBordes.bounds
            if objMetadato.stringValue != nil {
                self.urls = objMetadato.stringValue
                let navc = self.navigationController
                navc?.performSegueWithIdentifier("detalle", sender: self)
                
            }
            
        }
        
        
    }

}

