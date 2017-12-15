//
//  SwitchViewController.swift
//  Caculate
//
//  Created by tonny on 2017/11/27.
//  Copyright © 2017年 tonny. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height


class SwitchViewController: UIViewController ,UIWebViewDelegate,UIScrollViewDelegate{

    var webUrl: String?
    var AppAddressUrl:String?    
    lazy var webView:UIWebView = {
        ()->UIWebView in
        let tempWebView = UIWebView()
        tempWebView.delegate=self;
        tempWebView.scrollView.delegate=self
        return tempWebView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView = UIWebView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        if SCREEN_HEIGHT == 480 {
            self.webView.frame = CGRect.init(x: 0, y: 20, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        }
        
        let request = NSURLRequest.init(url: NSURL.init(string: self.webUrl!)! as URL)
        print("uuu = \(self.webUrl!)")
        self.webView.loadRequest(request as URLRequest)
        self.view.addSubview(self.webView)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.webView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.webView.frame=CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-49)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.webView.frame=CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-49)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if (request.url?.absoluteString.hasPrefix("itms-appss://"))!{
            UIApplication.shared.canOpenURL(request.url!)
            return false
        }else if (request.url?.absoluteString.hasPrefix("weixin://wap/pay?"))!{
            UIApplication.shared.canOpenURL(request.url!)
            return false
        }else if (request.url?.absoluteString.hasPrefix("https://myun.tenpay.com"))!{
            UIApplication.shared.canOpenURL(request.url!)
            return false
        }
        return true
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

