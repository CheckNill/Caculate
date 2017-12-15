//
//  ViewController.swift
//  Caculate
//
//  Created by tonny on 2017/11/27.
//  Copyright © 2017年 tonny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var ArrNums :NSMutableArray!
    var StrNum :NSMutableString!
    var resulet :Int32 = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.ArrNums = NSMutableArray.init()
        StrNum = NSMutableString.init()
        setUI()
    }
    
    func setUI() -> Void {
        for  view in self.view.subviews {
            if view .isKind(of: UIButton.classForCoder()) {
                if "0" == (view as! UIButton).title(for: UIControlState.normal)! {
//                    利用贝塞尔曲线和CAShapeLayer结合就可以实现；
                    let maskPath = UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.RawValue(UInt8(UIRectCorner.topLeft.rawValue) | UInt8(UIRectCorner.bottomLeft.rawValue) | UInt8(UIRectCorner.topRight.rawValue) | UInt8(UIRectCorner.bottomRight.rawValue))), cornerRadii: CGSize.init(width: view.frame.size.width*0.5, height: view.frame.size.width*0.5))
                    let maskLayer = CAShapeLayer.init()
                    maskLayer.frame = view.bounds
                    maskLayer.path = maskPath.cgPath
                    view.layer.mask = maskLayer
                }else{
                   Cornors(button: view as! UIButton)
                }
            }
        }
    }

    func Cornors(button:UIButton) -> Void {
        button.layer.cornerRadius=button.frame.size.width*0.5
        button.clipsToBounds = true
    }
    
    @IBAction func inputNubers(_ sender: UIButton) {
        let title:String = sender.title(for: UIControlState.normal)!
        StrNum.append(title)
        self.textField.text = StrNum! as String
    }
    
    func isCaculationCharacter(str:String) -> Bool {
        if str == "+/_" || str == "%" || str == "÷" || str == "×" || str == "-" || str == "+" || str == "AC" || str == "=" {
            return true
        }else{
           return false
        }
    }
    
    @IBAction func caculate(_ sender: UIButton) {
        let title:String = sender.title(for: UIControlState.normal)!
        self.ArrNums.add(self.textField.text as Any)
       

        if title == "AC" {
            textField.text = "0"
            self.ArrNums.removeAllObjects()
            resulet = 0
            StrNum = ""
            return
        }
        

        if self.ArrNums.count == 0 {
            self.ArrNums.add(title as Any)
        }else{
            if self.isCaculationCharacter(str: self.ArrNums.lastObject as! String) {
                self.ArrNums.replaceObject(at: self.ArrNums.count-1, with: title)
            }else{
                self.ArrNums.add(title as Any)
            }
            
            if self.ArrNums.count >= 3 {
                self.getValue()
            }
        }
        StrNum = ""
    }
    
    func getValue() -> Void {
//        if str == "+/_" || str == "%" || str == "÷" || str == "×" || str == "-" || str == "+" {
        let temp:String = self.ArrNums[1] as! String
        let temp0:String = self.ArrNums[0] as! String
        let temp2:String = self.ArrNums[2] as! String

        
        switch temp {
            case "+":
                resulet = Int32(Int(temp0)! + Int(temp2)!)
            case "-":
                resulet = Int32(Int(temp0)! - Int(temp2)!)
            case "×":
                resulet = Int32(Int(temp0)! * Int(temp2)!)
            case "÷":
                resulet = Int32(Int(temp0)! / Int(temp2)!)
            case "%":
                resulet = Int32(Int(temp0)! % Int(temp2)!)
            case "=":
                print("等于%@",self.ArrNums)
            case "AC":
                textField.text = "0"
                self.ArrNums.removeAllObjects()
                resulet = 0
                return
            default:
               print("Temporarily invalid %@",self.ArrNums)
               return
        }
       
        if self.ArrNums.lastObject as!String == "=" {
           self.ArrNums = []
        }else{
           self.ArrNums = ["\(resulet)",self.ArrNums.lastObject as Any]
        }
        
        self.textField.text = "\(resulet)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

