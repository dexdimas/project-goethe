//
//  ViewController.swift
//  project-goethe
//
//  Created by Andimas Bagaswara on 08/06/20.
//  Copyright © 2020 Andimas Bagaswara. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var lowerView: UIView!
    
    let session: AVCaptureSession = AVCaptureSession()
    
    var ball1 = UIView()
    var size1 = CGRect(x: 138, y: 215, width: 134, height: 134)
    
    var ball2 = UIView()
    var size2 = CGSize(width: 134, height: 134)
    
    var ball3 = UIView()
    var size3 = CGRect(x: 138, y: 550, width: 134, height: 134)
    
    var color = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        upperView.layer.cornerRadius = upperView.frame.width/2
        upperView.layer.backgroundColor = #colorLiteral(red: 1, green: 0.7850869894, blue: 0.1403126717, alpha: 1)
        middleView.layer.cornerRadius = upperView.frame.width/2
        middleView.layer.backgroundColor = #colorLiteral(red: 0.1907254457, green: 0.293775022, blue: 0.7033263445, alpha: 1)
        lowerView.layer.cornerRadius = upperView.frame.width/2
        lowerView.layer.backgroundColor = #colorLiteral(red: 0.4186630547, green: 0, blue: 0.4312154055, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        session.stopRunning()
        let launchedBefore = UserDefaults.standard.bool(forKey: "hasLaunched")
        if !launchedBefore {
            UserDefaults.standard.set(true, forKey: "hasLaunched")
            let launchStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let vc = launchStoryboard.instantiateViewController(identifier: "OnboardingStoryboard")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
        
//        session.sessionPreset = AVCaptureSession.Preset.high
//
//        if let device = AVCaptureDevice.default(for: AVMediaType.video) {
//            do {
//                try session.addInput(AVCaptureDeviceInput(device: device))
//
//            } catch {
//                print(error.localizedDescription)
//            }
//
//            let previewLayer = AVCaptureVideoPreviewLayer(session: session)
//
//            self.view.layer.addSublayer(previewLayer)
//            self.view.layer.insertSublayer(previewLayer, below: captureButton.layer)
//            previewLayer.frame = self.view.frame
//            previewLayer.videoGravity = .resizeAspectFill
//
//        }
//
//
//        session.startRunning()
//
//        let blur = UIBlurEffect(style: .regular)
//        let blurView = UIVisualEffectView(effect: blur)
//        blurView.frame = self.view.frame
//        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.view.addSubview(blurView)
//        self.view.layer.insertSublayer(blurView.layer, below: captureButton.layer)
    }
    
    private func setup1() {
        ball1.frame = size1
        ball1.backgroundColor = #colorLiteral(red: 1, green: 0.7850869894, blue: 0.1403126717, alpha: 1)
        ball1.layer.cornerRadius = size1.width/2
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(ball1DidTap))
        ball1.addGestureRecognizer(tap1)
        
        view.addSubview(ball1)
    }
    
    private func setup2() {
        ball2.frame.size = size2
        ball2.center = view.center
        ball2.backgroundColor = #colorLiteral(red: 0.1907254457, green: 0.293775022, blue: 0.7033263445, alpha: 1)
        ball2.layer.cornerRadius = size2.width/2
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(ball2DidTap))
        ball2.addGestureRecognizer(tap2)
        
        view.addSubview(ball2)
    }
    
    private func setup3() {
        ball3.frame = size3
        ball3.backgroundColor = #colorLiteral(red: 0.4186630547, green: 0, blue: 0.4312154055, alpha: 1)
        ball3.layer.cornerRadius = size3.width/2
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(ball3DidTap))
        ball3.addGestureRecognizer(tap3)
        
        view.addSubview(ball3)
    }
    
    @objc func ball1DidTap(_ sender: UITapGestureRecognizer) {
        ball1ZoomingOut()
//        ball2.isHidden = true
//        ball3.isHidden = true
    }
    
    @objc func ball2DidTap(_ sender: UITapGestureRecognizer) {
        ball2ZoomingOut()
//        ball1.isHidden = true
//        ball3.isHidden = true
    }
    
    @objc func ball3DidTap(_ sender: UITapGestureRecognizer) {
        ball3ZoomingOut()
//        ball1.isHidden = true
//        ball2.isHidden = true
    }
    
    
    private func ball1ZoomingOut() {
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.ball1.transform = CGAffineTransform(scaleX: 10, y: 10)
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2) {
                self.ball1.backgroundColor = #colorLiteral(red: 1, green: 0.7850869894, blue: 0.1403126717, alpha: 1)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                self.ball1.backgroundColor = #colorLiteral(red: 1, green: 0.7850869894, blue: 0.1403126717, alpha: 1)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2) {
                self.ball1.backgroundColor = #colorLiteral(red: 1, green: 0.7850869894, blue: 0.1403126717, alpha: 1)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                self.ball1.backgroundColor = #colorLiteral(red: 1, green: 0.7850869894, blue: 0.1403126717, alpha: 1)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                self.ball1.backgroundColor = #colorLiteral(red: 1, green: 0.7850869894, blue: 0.1403126717, alpha: 1)
            }
            self.view.willRemoveSubview(self.ball1)
            self.color = #colorLiteral(red: 1, green: 0.7850869894, blue: 0.1403126717, alpha: 1)
            let previewVC = UIStoryboard(name: "Studio", bundle: nil).instantiateViewController(withIdentifier: "studioVIew")
            previewVC.modalPresentationStyle = .fullScreen
            self.show(previewVC, sender: self)
        })
    }
    
    private func ball2ZoomingOut() {
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.ball2.transform = CGAffineTransform(scaleX: 10, y: 10)
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2) {
                self.ball2.backgroundColor = #colorLiteral(red: 0.1907254457, green: 0.293775022, blue: 0.7033263445, alpha: 1)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                self.ball2.backgroundColor = #colorLiteral(red: 0.1907254457, green: 0.293775022, blue: 0.7033263445, alpha: 1)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2) {
                self.ball2.backgroundColor = #colorLiteral(red: 0.1907254457, green: 0.293775022, blue: 0.7033263445, alpha: 1)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                self.ball2.backgroundColor = #colorLiteral(red: 0.1907254457, green: 0.293775022, blue: 0.7033263445, alpha: 1)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                self.ball2.backgroundColor = #colorLiteral(red: 0.1907254457, green: 0.293775022, blue: 0.7033263445, alpha: 1)
            }
            self.view.willRemoveSubview(self.ball2)
            self.color = #colorLiteral(red: 0.1907254457, green: 0.293775022, blue: 0.7033263445, alpha: 1)
            let previewVC = UIStoryboard(name: "Studio", bundle: nil).instantiateViewController(withIdentifier: "studioVIew")
            previewVC.modalPresentationStyle = .fullScreen
            self.show(previewVC, sender: self)
        })
    }
    
    private func ball3ZoomingOut() {
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.ball3.transform = CGAffineTransform(scaleX: 10, y: 10)
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2) {
                self.ball3.backgroundColor = #colorLiteral(red: 0.4186630547, green: 0, blue: 0.4312154055, alpha: 1)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                self.ball3.backgroundColor = #colorLiteral(red: 0.4186630547, green: 0, blue: 0.4312154055, alpha: 1)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2) {
                self.ball3.backgroundColor = #colorLiteral(red: 0.4186630547, green: 0, blue: 0.4312154055, alpha: 1)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                self.ball3.backgroundColor = #colorLiteral(red: 0.4186630547, green: 0, blue: 0.4312154055, alpha: 1)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                self.ball3.backgroundColor = #colorLiteral(red: 0.4186630547, green: 0, blue: 0.4312154055, alpha: 1)
            }
            self.view.willRemoveSubview(self.ball3)
            self.color = #colorLiteral(red: 0.4186630547, green: 0, blue: 0.4312154055, alpha: 1)
            let previewVC = UIStoryboard(name: "Studio", bundle: nil).instantiateViewController(withIdentifier: "studioVIew")
            previewVC.modalPresentationStyle = .fullScreen
            self.show(previewVC, sender: self)
        })
    }
}

