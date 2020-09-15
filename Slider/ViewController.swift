//
//  ViewController.swift
//  Slider
//
//  Created by DiRai on 15/09/20.
//  Copyright © 2020 DiRai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var imageNameArray = [ "01.square.fill", "02.square.fill", "03.square.fill", "04.square.fill", "05.square.fill", "06.square.fill", "07.square.fill", "08.square.fill", "09.square.fill", "10.square.fill", ]
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    var currentPage : Int {
        return pageControl.currentPage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator =  false
        collectionView.isPagingEnabled = true
        
        setupPageControl()
    }
    
    func setupPageControl(){
        prevButton.isEnabled = false
        pageControl.numberOfPages = imageNameArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNameArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! SliderCollectionViewCell
        cell.image.image = UIImage( systemName: imageNameArray[indexPath.row] )
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width )
        updateButtonStatus()
    }
    
    @IBAction func prevButtonTapped(_ sender: UIButton) {
        pageControl.currentPage = currentPage - 1
        updateButtonStatus()
        scrollUICollectionView()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        pageControl.currentPage = currentPage + 1
        updateButtonStatus()
        scrollUICollectionView()
    }
    
    func updateButtonStatus(){
        if currentPage <= 0{
            prevButton.isEnabled = false
        }else if currentPage >= imageNameArray.count - 1{
            nextButton.isEnabled = false
        }else{
            prevButton.isEnabled = true
            nextButton.isEnabled = true
        }
    }
    
    func scrollUICollectionView(){
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

