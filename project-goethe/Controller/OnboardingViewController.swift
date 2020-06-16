//
//  OnboardingViewController.swift
//  project-goethe
//
//  Created by Andimas Bagaswara on 12/06/20.
//  Copyright © 2020 Andimas Bagaswara. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let pages = OnboardingContent().pages
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        previousButton.isHidden = true
        
        // register the custom CollectionViewCell and assign the delegates to the ViewController
        self.collectionView.backgroundColor = .white
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: OnboardingCollectionViewCell.identifier, bundle: Bundle.main),
                                     forCellWithReuseIdentifier: "OnboardingCollectionViewCell")
        
        // set the number of pages to the number of Onboarding Screens
        self.pageControl.numberOfPages = self.pages.count
    }
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        // scrolling the collectionView to the selected page
        collectionView.scrollToItem(at: IndexPath(item: sender.currentPage, section: 0),
                                    at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        if pageControl.currentPage == pages.count - 1 {
            dismiss(animated: false)
            return
        }
        
        pageControl.currentPage = pageControl.currentPage + 1
        collectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage, section: 0), at: .centeredHorizontally, animated: true)
        changeNavigationButton()
    }
    
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        pageControl.currentPage = pageControl.currentPage - 1
        collectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage, section: 0), at: .centeredHorizontally, animated: true)
        changeNavigationButton()
    }
    
    func changeNavigationButton() {
        continueButton.setTitle("Next", for: .normal)
        if pageControl.currentPage == pages.count - 1 {
            continueButton.setTitle("Done", for: .normal)
        }
        
        previousButton.isHidden = true
        if pageControl.currentPage != 0 {
            previousButton.isHidden = false
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier,
                                                      for: indexPath) as! OnboardingCollectionViewCell
        // function for configuring the cell, defined in the Custom cell class
        cell.configureCell(page: pages[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        changeNavigationButton()
    }
    
}
