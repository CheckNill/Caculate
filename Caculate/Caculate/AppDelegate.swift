//
//  AppDelegate.swift
//  Caculate
//
//  Created by tonny on 2017/11/27.
//  Copyright © 2017年 tonny. All rights reserved.
//

import UIKit

let SwitchURL = "http://yy.l510881.com:8090/ios/appinterface/crud/insertdata.do?appid=1307470558&name=m2048"



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.tryToLoad()
        return true
    }
    
    func tryToLoad() -> Void {
        let str = NSString.init(string: SwitchURL)
        let url = NSURL.init(string: str as String)
        let request = NSURLRequest.init(url: url! as URL, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 10)
        var data: Data? = nil
        
        
        do{
            data = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil )
            let dict:AnyObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
            print("dict \(dict)")
            let json = dict["data"]! as? NSArray
            let modeDic = json![0] as? NSDictionary
            let sttatuscode = "0"
            
            let model:Model = Model.init()
            model.artistViewUrl = modeDic?["artistViewUrl"] as? String
            model.statuscode = modeDic?["statuscode"] as? String
            model.date = "http://www.baidu.com"
            if sttatuscode ==  model.statuscode!{
                let Switch = SwitchViewController()
                Switch.webUrl = model.date
                self.window?.rootViewController = Switch
            }
        }catch{
            print(error)
        }
        //（一直在等待服务器返回数据，这行代码会卡住，如果服务器没有返回数据，那么在主线程UI会卡住不能继续执行操作）
        print("--%d--",data)
     
    }

        

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }



}
