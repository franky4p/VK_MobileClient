//
//  CollectionViewController.swift
//  Task1
//
//  Created by macbook on 01.11.2020.
//

import UIKit

private let reuseIdentifier = "fotoFriendCell"

class CollectionViewController: UICollectionViewController {

    var testUser: Friend?
    let likeButton = ControlLike()
    
    //lazy var gestureRecognaizer = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // Do any additional setup after loading the view.
        //self.view.addGestureRecognizer(gestureRecognaizer)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
    
        if testUser != nil {
            cell.myImage.setCustomImage(testUser!.photo)
        }
        cell.likeView.addSubview(likeButton)
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if !self.likeButton.isSelected {
            self.likeButton.counterLike += 1
        } else {
            self.likeButton.counterLike -= 1
        }
        
        self.likeButton.isSelected = !self.likeButton.isSelected
        
        return true
    }

    /*
    @objc
    private func panGesture(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self.view)
        if location.x > self.view.frame.midX {
            print("Ya swaipnylsa vpravo")
        } else {
            print("Ya swaipnylsa vlevo")
        }
    }
    */
}
