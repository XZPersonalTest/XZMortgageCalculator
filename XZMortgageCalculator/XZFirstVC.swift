//
//  XZFirstVC.swift
//  XZMortgageCalculator
//
//  Created by LWX on 2017/9/1.
//  Copyright © 2017年 LWX. All rights reserved.
//

//: 第1天大作业

//: 用面向过程的技能，实现一个房贷计算器。每个同学，必须阐述实现原理。


//: 假设小波贷款买了一套房，房贷总价 150万元，利率4.9%，分期30年，首付3成。 求按等额本金还款方式下，每个月利息列表 和 购买此套房的总花费。


import UIKit

class XZFirstVC: UIViewController {
    // 总价输入框
    private var totalPrice : UITextField!
    // 利率输入框
    private var interestRate : UITextField!
    // 分多少期输入框
    private var instalment : UITextField!
    // 首付输入框
    private var downPayment : UITextField!
    
    // 总花费显示框
    private var sumLabel : UILabel!
    
    // 结果显示框
    private var resultTextView : UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "等额本金"
        
        // 配置UI
        setUpNUI()
        
    }
    
    // 配置UI
    private func setUpNUI() {
        
        // 核算按钮
        let countBtn = UIButton(frame: CGRect(x: 20, y: 70, width: 40, height: 40))
        countBtn.setTitle("核算", for: UIControlState.normal)
        countBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        countBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        countBtn.backgroundColor = UIColor.green
        countBtn.layer.masksToBounds = true
        countBtn.layer.cornerRadius = 20
        countBtn.layer.borderWidth = 4
        countBtn.layer.borderColor = UIColor.yellow.cgColor
        countBtn.addTarget(self, action: #selector(touchContAction), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(countBtn)
        
        // 核算总价  sumLabel
        sumLabel = UILabel(frame: CGRect(x: 10, y: 300, width: self.view.bounds.width - 20, height: 30))
        sumLabel.backgroundColor = UIColor.green
        sumLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(sumLabel)
        
        resultTextView = UITextView(frame: CGRect(x: 10, y: 340, width: self.view.bounds.width - 20, height: self.view.bounds.height - 350))
        resultTextView.backgroundColor = UIColor.green
        resultTextView.isEditable = false
        
        self.view.addSubview(resultTextView)
        
        // 配置导航栏
        setUpNav()
        
        // 配置label
        for i in 0..<4 {
            setUpLabel(index: i)
        }
        
        // 配置输入框
        setUpTextField()
        
    }
    
    // 配置导航栏
    private func setUpNav() {
        
        let rightButton = UIBarButtonItem(title: "等额本息", style: .plain, target: self, action:#selector(rightBarBtnAction))
        
        navigationItem.setRightBarButton(rightButton, animated: false)
        
    }
    // 点击导航栏右侧按钮
    @objc private func rightBarBtnAction() {
        
        let secondVC = XZSecondVC()
        
        navigationController?.pushViewController(secondVC, animated: true)
        
    }
    
    
    
    // 配置label
    private func setUpLabel(index: NSInteger) {
        
        let label = UILabel(frame: CGRect(x: 60, y: 100 + 50 * index, width: 110, height: 30))
        switch index {
        case 0:label.text = "总价(单位:万):"
        case 1:label.text = "利率:"
        case 2:label.text = "分期(单位:年):"
        case 3:label.text = "首付(单位:成):"
        default: break
        }
        label.backgroundColor = UIColor.green
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        
    }
    
    // 配置输入框
    private func setUpTextField() {
        // 总价
        totalPrice = UITextField(frame: CGRect(x: 175, y: 100, width: 110, height: 30))
        totalPrice.backgroundColor = UIColor.green
//        totalPrice.text = "150"
        // 利率
        interestRate = UITextField(frame: CGRect(x: 175, y: 100 + 50, width: 110, height: 30))
        interestRate.backgroundColor = UIColor.green
//        interestRate.text = "4.9"
        // 分期
        instalment = UITextField(frame: CGRect(x: 175, y: 100 + 100, width: 110, height: 30))
        instalment.backgroundColor = UIColor.green
//        instalment.text = "30"
        // 首付
        downPayment = UITextField(frame: CGRect(x: 175, y: 100 + 150, width: 110, height: 30))
        downPayment.backgroundColor = UIColor.green
//        downPayment.text = "3"
        
        self.view.addSubview(totalPrice)
        self.view.addSubview(interestRate)
        self.view.addSubview(instalment)
        self.view.addSubview(downPayment)
    }
    
    // 点击核算按钮方法
    @objc private func touchContAction() {
        
        if (totalPrice.text == "") {
            sumLabel.text = "总价不能为空"
            return
        }
        if (interestRate.text == "") {
            sumLabel.text = "利率不能为空"
            return
        }
        if (instalment.text == "") {
            sumLabel.text = "期数不能为空"
            return
        }
        if (downPayment.text == "") {
            sumLabel.text = "首付成数不能为空"
            return
        }
        
        // 总价
        let totalPriceString = Double(totalPrice.text!)!
        
        
        // 首付
        let downPaymentStr = totalPriceString * (Double(downPayment.text!)! / 10)
        
        // 总共需要贷款金额
        let sumLending = totalPriceString - downPaymentStr
        
        
        // 平均每月等额归还本金
        let principal : Double = sumLending / (Double(instalment.text!)! * 12) * 10000
        
        // 平均每月利率  将年利率分为12份
        let interestRateAvg : Double = Double(interestRate.text!)! / 12
        
        // 本金+利息
        var principalAndInterestArr = [Double]()
        
        // 纯利息
        var interestArr = [Double]()
        
        // 计算每月本息
        for i in 0..<(Int(instalment.text!)! * 12) {
            // 每月利息
            let interest = (sumLending * 10000 - principal * Double(i)) * (interestRateAvg / 100)
            
            interestArr.append(interest)
            
            // 每月本金+利息
            let principalAndInterest = principal + interest
            
            principalAndInterestArr.append(principalAndInterest)
            
        }
        
        // 计算总花费   首付+每月需还本息
        var sunFloat : Double = downPaymentStr * 10000
        
        var resultStr = ""
        
        for principalAndInterest in principalAndInterestArr {
            
            sunFloat = principalAndInterest + sunFloat
            
            let resultString = "第\(principalAndInterestArr.index(of: principalAndInterest)! + 1)个月需还利息(单位:元):\(interestArr[principalAndInterestArr.index(of: principalAndInterest)!]), 需还本金+利息(单位:元):\(principalAndInterest)"
            
            if (resultStr == "") {
                resultStr = resultString
            }
            else
            {
                resultStr = "\(resultStr) \n \(resultString)"
            }
            
            
        }
        
        sumLabel.text = "总花费(单位:元):\(sunFloat)\n"
        
        resultTextView.text = resultStr
    }
    
    
    // 键盘回落
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        totalPrice.resignFirstResponder()
        interestRate.resignFirstResponder()
        instalment.resignFirstResponder()
        downPayment.resignFirstResponder()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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




