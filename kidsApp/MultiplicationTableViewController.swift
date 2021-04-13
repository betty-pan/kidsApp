//
//  MultiplicationTableViewController.swift
//  kidsApp
//
//  Created by Betty Pan on 2021/4/11.
//

import UIKit

class MultiplicationTableViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/scrollView.bounds.width
        pageControl.currentPage = Int(page)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func changePage(_ sender: UIPageControl) {
        let point = CGPoint(x: scrollView.bounds.width * (CGFloat(sender.currentPage)), y: 0)
        scrollView.setContentOffset(point, animated: true)
    }
    
    @IBAction func backToMainPage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
}
