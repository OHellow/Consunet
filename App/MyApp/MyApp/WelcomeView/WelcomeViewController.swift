//
//  WelcomeViewController.swift
//  MyApp
//
//  Created by Satsishur on 06.04.2020.
//  Copyright © 2020 Consumeda. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    let pages = [ Page(imageName: "no image", textString: "Welcome to Consunet!"),
                  Page(imageName: "firstImage", textString: "Step 1. Choose the category"),
                  Page(imageName: "secndImage", textString: "Step 2. Search for your product"),
                  Page(imageName: "thirdImage", textString: "Step 3. Fill the order data and click on Send button")
    ]
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor(red: 52/255, green: 59/255, blue: 70/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = UIColor(red: 52/255, green: 59/255, blue: 70/255, alpha: 1)
        pc.pageIndicatorTintColor = UIColor(red: 159/255, green: 190/255, blue: 253/255, alpha: 1)
        return pc
    }()
    
    @objc private func handleToContactInfo() {
        performSegue(withIdentifier: "goToContact", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
        createControlStack()
        self.overrideUserInterfaceStyle = .light
    }
    
    func createView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "cellID")
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.backgroundColor = .white
    }
    
    func createControlStack() {
        let controlStack = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        controlStack.translatesAutoresizingMaskIntoConstraints = false
        controlStack.distribution = .fillEqually
        view.addSubview(controlStack)
        controlStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        controlStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        controlStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        controlStack.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }

}

extension WelcomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        cell.imageView.image = UIImage(named: page.imageName)
        cell.descriptionTextView.text = page.textString
        cell.button.addTarget(self, action: #selector(handleToContactInfo), for: .touchUpInside)
        if indexPath.item == pages.count - 1 {
            cell.button.isHidden = false
            cell.button.isEnabled = true
        } else {
            cell.button.isHidden = true
            cell.button.isEnabled = false
        }
        return cell
    }
}

extension WelcomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
