//
//  PhotoViewTransition.swift
//  Facebook
//
//  Created by Sampo Karjalainen on 6/16/16.
//

import UIKit

class PhotoViewTransition: BaseTransition {
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        let transitioningImageView: UIImageView = UIImageView()
        
        let tabViewController = fromViewController as! UITabBarController
        let navigationController = tabViewController.selectedViewController as! UINavigationController
        let newsFeedViewController = navigationController.topViewController as! NewsFeedViewController
        let photoViewController = toViewController as! PhotoViewController
        
        transitioningImageView.image = newsFeedViewController.selectedImageView.image
        transitioningImageView.frame = containerView.convertRect(newsFeedViewController.selectedImageView.frame, fromView: newsFeedViewController.selectedImageView.superview)
        transitioningImageView.contentMode = newsFeedViewController.selectedImageView.contentMode
        transitioningImageView.clipsToBounds = true
        containerView.addSubview(transitioningImageView)
        
        newsFeedViewController.selectedImageView.hidden = true
        photoViewController.mainScrollView.hidden = true
        
        photoViewController.view.alpha = 0
        
        UIView.animateWithDuration(duration, animations: {
            transitioningImageView.frame = CGRect(x: 0, y: 56, width: 320, height: 467)
            photoViewController.view.alpha = 1
        }) { (finished: Bool) -> Void in
            transitioningImageView.removeFromSuperview()
            newsFeedViewController.selectedImageView.hidden = false
            photoViewController.mainScrollView.hidden = false
            self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let transitioningImageView: UIImageView = UIImageView()
        
        let tabViewController = toViewController as! UITabBarController
        let navigationController = tabViewController.selectedViewController as! UINavigationController
        let newsFeedViewController = navigationController.topViewController as! NewsFeedViewController
        let photoViewController = fromViewController as! PhotoViewController
        
        transitioningImageView.image = photoViewController.imageViews[photoViewController.selectedImageIndex].image
        transitioningImageView.frame = containerView.convertRect(photoViewController.imageViews[photoViewController.selectedImageIndex].frame, fromView: photoViewController.imageViews[photoViewController.selectedImageIndex].superview)

        transitioningImageView.contentMode = photoViewController.imageViews[photoViewController.selectedImageIndex].contentMode
        transitioningImageView.clipsToBounds = true
        containerView.addSubview(transitioningImageView)
        
        photoViewController.mainScrollView.hidden = true
        
        UIView.animateWithDuration(duration, animations: {
            transitioningImageView.frame = containerView.convertRect(newsFeedViewController.imageViews[photoViewController.selectedImageIndex].frame, fromView: newsFeedViewController.selectedImageView.superview)
            photoViewController.view.alpha = 0
        }) { (finished: Bool) -> Void in
            transitioningImageView.removeFromSuperview()
            photoViewController.mainScrollView.hidden = false
            self.finish()
        }
    }
}
