//
//  OURSEScrollViewVC.swift
//  WaveWalk
//
//  Created by Arno de Jonge on 22/02/2017.
//  Copyright © 2017 Arno de Jonge. All rights reserved.
//

import UIKit

class COURSEScrollViewVC: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!

    var images = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
    
        
        var contentWidth: CGFloat = 0.0
        
        print("\(scrollView.frame.size.width)")

        let scrollWidth = scrollView.frame.size.width
        
        for x in 0...2{
            let image = UIImage(named: "icon\(x).png")
            let imageView = UIImageView(image: image)
            images.append(imageView)
            
            
            var newX: CGFloat = 0.0
            
            newX = scrollWidth / 2 + scrollView.frame.size.width * CGFloat(x)
            
            contentWidth += newX
            
            scrollView.addSubview(imageView)
            
            imageView.frame = CGRect(x: newX - 75/*75 being half of the image size*/, y: (scrollView.frame.size.height / 2) - 75, width: 150, height: 150)
            
            
            
            
        }
        scrollView.clipsToBounds = false
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
        
        print("Count: \(images.count)")
        
    }


}
