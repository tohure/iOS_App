//
//  DetalleNoticiaVC.swift
//  RppApp_iOS
//
//  Created by Huamán Torres, Carlo Renzo on 20/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import UIKit

class DetalleNoticiaVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var thumbNotice: UIImageView!
    
    var currentShownEvent : Noticia!
    
    let tableHeaderHeight: CGFloat = 300.0
    var headerView: UIView!
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().postNotificationName("llamaMiControlador", object: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView .setContentOffset(CGPointMake(0, -295), animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().postNotificationName("llamaMiControlador", object: true)
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
        
        //self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0) // Status bar inset

        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = .None
        
        
        thumbNotice.sd_setImageWithURL(NSURL(string: currentShownEvent.linkimg), placeholderImage: UIImage(named: "placeholder_img"))
        
        
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        
        tableView.addSubview(headerView)
        
        tableView.contentInset = UIEdgeInsets(top: tableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -tableHeaderHeight)
        
        updateHeaderView()
        tableView .reloadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickInput(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle { return .LightContent }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    // MARK: - Convenience
    
    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -tableHeaderHeight, width: tableView.bounds.width, height: tableHeaderHeight)
        if tableView.contentOffset.y < -tableHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        headerView.frame = headerRect
    }
    
    // MARK: - Satus Bar
    
    /*override func prefersStatusBarHidden() -> Bool {
        return true
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetalleNoticiaVC : UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DynamicCell", forIndexPath: indexPath) as! DynamicTableViewCell
        
        cell.titleLabel.text = currentShownEvent.titular
        cell.bodyLabel.attributedText = handleHtml(currentShownEvent.desarrollo)
        
        return cell
    }
    
    func handleHtml(string : String) -> NSAttributedString{
        var returnStr = NSMutableAttributedString()
        do {
            returnStr = try NSMutableAttributedString(data: string.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            
            let fullRange : NSRange = NSMakeRange(0, returnStr.length)
            returnStr.addAttributes([NSFontAttributeName : UIFont(name: "Helvetica Neue", size: 18.0)!], range: fullRange)
            
        } catch {
            print(error)
        }
        return returnStr
    }
    
}


