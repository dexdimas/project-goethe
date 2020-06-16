//
//  CameraViewController.swift
//  project-goethe
//
//  Created by Andimas Bagaswara on 13/06/20.
//  Copyright © 2020 Andimas Bagaswara. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var flashButton: UIButton!
    
    let lineShape = CAShapeLayer()
    let previewLayer = CALayer()
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
    var backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    var capturePhotoOutput: AVCapturePhotoOutput?
    
    var flashMode: AVCaptureDevice.FlashMode? = .off
    
    var center: CGPoint = CGPoint(x: UIScreen.main.bounds.width/2-15, y: UIScreen.main.bounds.width/2-15)
    let queue = DispatchQueue(label: "com.camera.video.queue")
    
    var color: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCrosshairs()
        prepareCamera()
    }
    
    func prepareCamera() {
        // Do any additional setup after loading the view.
        let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.frame = view.layer.bounds
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            cameraView.layer.addSublayer(videoPreviewLayer!)
            captureSession?.startRunning()
        } catch {
            print("Error Detected")
        }
        
        capturePhotoOutput = AVCapturePhotoOutput()
        capturePhotoOutput?.isHighResolutionCaptureEnabled = true
        captureSession?.addOutput(capturePhotoOutput!)
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable: NSNumber(value: kCMPixelFormat_32BGRA)] as? [String : Any]
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.setSampleBufferDelegate(self, queue: queue)
        captureSession?.addOutput(videoOutput)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        CVPixelBufferLockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: CVOptionFlags(0)))
        guard let baseAddr = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0) else {
            return
        }
        
        let width = CVPixelBufferGetWidthOfPlane(imageBuffer, 0)
        let height = CVPixelBufferGetHeightOfPlane(imageBuffer, 0)
        let bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(imageBuffer, 0)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bimapInfo: CGBitmapInfo = [
            .byteOrder32Little,
            CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)]
        
        guard let content = CGContext(data: baseAddr, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bimapInfo.rawValue) else {
            return
        }
        
        guard let cgImage = content.makeImage() else {
            return
        }
        
        DispatchQueue.main.async {
            self.previewLayer.contents = cgImage
            let color = self.previewLayer.pickColor(at: self.center)
            self.color = color
            self.lineShape.strokeColor = color?.cgColor
        }
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        guard error == nil, let photoSampleBuffer = photoSampleBuffer else {
            print("Error Detected")
            return
        }
        guard let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer) else {
            return
        }
        
        let capturedImage = UIImage.init(data: imageData, scale: 1.0)
        if let image = capturedImage {
            //            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            
            let previewVC = UIStoryboard(name: "Preview", bundle: nil).instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
            
            previewVC.modalPresentationStyle = .fullScreen
            previewVC.takenPhoto = image
            previewVC.takenColor = color
            
            DispatchQueue.main.async {
                self.show(previewVC, sender: self)
                self.captureSession?.stopRunning()
                
            }
        }
    }
    
    func setupCrosshairs() {
        previewLayer.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-30, height: UIScreen.main.bounds.width-30)
        previewLayer.position = view.center
        previewLayer.contentsGravity = CALayerContentsGravity.resizeAspectFill
        previewLayer.masksToBounds = true
        previewLayer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 2.0)))
        
        let linePath = UIBezierPath.init(ovalIn: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        lineShape.frame = CGRect.init(x: UIScreen.main.bounds.width/2-20, y:UIScreen.main.bounds.height/2-20, width: 40, height: 40)
        lineShape.lineWidth = 5
        lineShape.strokeColor = UIColor.red.cgColor
        lineShape.path = linePath.cgPath
        lineShape.fillColor = UIColor.clear.cgColor
        self.view.layer.insertSublayer(lineShape, at: 1)
        
        let linePath1 = UIBezierPath.init(ovalIn: CGRect.init(x: 0, y: 0, width: 8, height: 8))
        let lineShape1 = CAShapeLayer()
        lineShape1.frame = CGRect.init(x: UIScreen.main.bounds.width/2-4, y:UIScreen.main.bounds.height/2-4, width: 8, height: 8)
        lineShape1.path = linePath1.cgPath
        lineShape1.fillColor = UIColor.init(white: 0.7, alpha: 0.5).cgColor
        self.view.layer.insertSublayer(lineShape1, at: 1)
    }
    
    @IBAction func captureButtonTapped(_ sender: UIButton) {
        guard let capturePhotoOutput = self.capturePhotoOutput else { return }
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = flashMode ?? .off
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    func switchToFrontCamera() {
        if frontCamera?.isConnected == true {
            captureSession?.stopRunning()
            let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice!)
                captureSession = AVCaptureSession()
                captureSession?.addInput(input)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                videoPreviewLayer?.frame = view.layer.bounds
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                cameraView.layer.addSublayer(videoPreviewLayer!)
                captureSession?.startRunning()
            } catch {
                print("Error Detected")
            }
        }
    }
    
    func switchToBackCamera() {
        if backCamera?.isConnected == true {
            captureSession?.stopRunning()
            let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice!)
                captureSession = AVCaptureSession()
                captureSession?.addInput(input)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                videoPreviewLayer?.frame = view.layer.bounds
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                cameraView.layer.addSublayer(videoPreviewLayer!)
                captureSession?.startRunning()
            } catch {
                print("Error Detected")
            }
        }
    }
    
    @IBAction func rotateButtonTapped(_ sender: UIButton) {
        guard let currentCameraInput: AVCaptureInput = captureSession?.inputs.first else { return }
        if let input = currentCameraInput as? AVCaptureDeviceInput {
            if input.device.position == .back {
                switchToFrontCamera()
            }
            if input.device.position == .front {
                switchToBackCamera()
            }
        }
    }
    
    @IBAction func flashButtonTapped(_ sender: UIButton) {
        let mode = flashMode
        switch mode {
        case .off:
            flashButton.setBackgroundImage(UIImage(systemName: "bolt"), for: .normal)
            flashMode = .on
        case .auto:
            flashButton.setBackgroundImage(UIImage(systemName: "bolt.badge.a"), for: .normal);
            flashMode = .auto
        case .on:
            flashButton.setBackgroundImage(UIImage(systemName: "bolt.slash"), for: .normal)
            flashMode = .off
        default:
            print("Error Detected")
            break
        }
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

extension CALayer {
    
    /// Get the color of a specific location
    ///
    /// - parameter at: Position
    ///
    /// - returns: Color
    func pickColor(at position: CGPoint) -> UIColor? {
        
        // Used to store the target pixel value
        var pixel = [UInt8](repeatElement(0, count: 4))
        // The color space is RGB, which determines whether the output color encoding is RGB or other (such as YUV)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        // Set the bitmap color distribution to RGBA
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
        guard let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo) else {
            return nil
        }
        // Set context origin offset to all coordinates of target position
        context.translateBy(x: -position.x, y: -position.y)
        // Render the image into the context
        render(in: context)
        let color = UIColor(
            red: CGFloat(pixel[0]) / 255.0,
            green: CGFloat(pixel[1]) / 255.0,
            blue: CGFloat(pixel[2]) / 255.0,
            alpha: CGFloat(pixel[3]) / 255.0)
        return color
    }
}
