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
        photoViewController.mainImageView.contentMode = newsFeedViewController.selectedImageView.contentMode
        transitioningImageView.clipsToBounds = true
        containerView.addSubview(transitioningImageView)
        
        newsFeedViewController.selectedImageView.hidden = true
        photoViewController.mainImageView.hidden = true
        
        photoViewController.view.alpha = 0
        
        UIView.animateWithDuration(duration, animations: {
            transitioningImageView.frame = photoViewController.mainImageView.frame
            photoViewController.view.alpha = 1
        }) { (finished: Bool) -> Void in
            transitioningImageView.removeFromSuperview()
            newsFeedViewController.selectedImageView.hidden = false
            photoViewController.mainImageView.hidden = false
            self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let transitioningImageView: UIImageView = UIImageView()
        
        let tabViewController = toViewController as! UITabBarController
        let navigationController = tabViewController.selectedViewController as! UINavigationController
        let newsFeedViewController = navigationController.topViewController as! NewsFeedViewController
        let photoViewController = fromViewController as! PhotoViewController
        
        transitioningImageView.image = photoViewController.mainImageView.image
        transitioningImageView.frame = containerView.convertRect(photoViewController.mainImageView.frame, fromView: photoViewController.mainImageView.superview)
        transitioningImageView.contentMode = photoViewController.mainImageView.contentMode
        transitioningImageView.clipsToBounds = true
        containerView.addSubview(transitioningImageView)
        
        newsFeedViewController.selectedImageView.hidden = true
        photoViewController.mainImageView.hidden = true
                
        UIView.animateWithDuration(duration, animations: {
            transitioningImageView.frame = containerView.convertRect(newsFeedViewController.selectedImageView.frame, fromView: newsFeedViewController.selectedImageView.superview)
            photoViewController.view.alpha = 0
        }) { (finished: Bool) -> Void in
            transitioningImageView.removeFromSuperview()
            newsFeedViewController.selectedImageView.hidden = false
            photoViewController.mainImageView.hidden = false
            self.finish()
        }
    }
}
