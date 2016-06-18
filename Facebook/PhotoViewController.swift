//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Sampo Karjalainen on 6/16/16.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var shownImage: UIImage!
    var selectedImageIndex: Int = 0
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var photoActions: UIImageView!
    @IBOutlet var imageViews: [UIImageView]!
    
    var transitioning: Bool = false
    var prevZoom: CGFloat = 1
    var currentZoom: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(width: view.frame.size.width * 5, height: view.frame.size.height)
        scrollView.delegate = self
        scrollView.contentOffset.x = CGFloat(selectedImageIndex) * view.frame.width
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if !transitioning && scrollView.zoomScale <= 1 {
            let alpha = max(1 - abs(scrollView.contentOffset.y / 150.0), 0.25)
            view.backgroundColor =
            UIColor(white: 0, alpha: alpha)
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if scrollView.zoomScale == 1 {
            UIView.animateWithDuration(0.3, animations: {
                self.doneButton.alpha = 0
                self.photoActions.alpha = 0
            })
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (abs(scrollView.contentOffset.y) > 70 && scrollView.zoomScale == 1) {
            transitioning = true
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            UIView.animateWithDuration(0.3, animations: {
                self.doneButton.alpha = 1
                self.photoActions.alpha = 1
            })
        }
    }

    func scrollViewDidZoom(scrollView: UIScrollView) {
        prevZoom = currentZoom // Hack to get the last before bounce back
        currentZoom = scrollView.zoomScale
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        if prevZoom < 0.9 {
            transitioning = true
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageViews[Int(scrollView.contentOffset.x / view.frame.width)]
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDone(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
