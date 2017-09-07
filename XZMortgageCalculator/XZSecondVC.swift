//
//  XZSecondVC.swift
//  XZMortgageCalculator
//
//  Created by LWX on 2017/9/1.
//  Copyright © 2017年 LWX. All rights reserved.
//

//: 第1天大作业

//: 用面向过程的技能，实现一个房贷计算器。每个同学，必须阐述实现原理。


//: 假设小波贷款买了一套房，房贷总价 150万元，利率4.9%，分期30年，首付3成。 求按等额本金还款方式下，每个月利息列表 和 购买此套房的总花费。


import UIKit

class XZSecondVC: UIViewController {
    
    // 总价输入框
    private var totalPrice : UITextField!
    // 利率输入框
    private var interestRate : UITextField!
    // 分期输入框
    private var instalment : UITextField!
    // 首付输入框
    private var downPayment : UITextField!
    
    // 总花费显示框
    private var sumLabel : UILabel!
    
    // 每月需还金额显示框
    private var resultTextView : UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "等额本息"
        self.view.backgroundColor = UIColor.white
        
        // 配置UI
        setUpUI()
        
        
        // Do any additional setup after loading the view.
    }
    
    private func setUpUI() {
        // 核算按钮
        let countBrn = UIButton(frame: CGRect(x: 20, y: 70, width: 40, height: 40))
        countBrn.setTitle("核算", for: UIControlState.normal)
        countBrn.setTitleColor(UIColor.black, for: UIControlState.normal)
        countBrn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        countBrn.backgroundColor = UIColor.green
        countBrn.layer.masksToBounds = true
        countBrn.layer.cornerRadius = 20
        countBrn.layer.borderWidth = 4
        countBrn.layer.borderColor = UIColor.yellow.cgColor
        countBrn.addTarget(self, action: #selector(touchContAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(countBrn)
        
        // 总花费显示框
        sumLabel = UILabel(frame: CGRect(x: 10, y: 300, width: self.view.bounds.width - 20, height: 30))
        sumLabel.backgroundColor = UIColor.green;
        sumLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(sumLabel)
        
        // 每月需还金额显示框
        resultTextView = UITextView(frame: CGRect(x: 10, y: 340, width: self.view.bounds.width - 20, height: self.view.bounds.size.height - 350))
        resultTextView.backgroundColor = UIColor.green
        resultTextView.isEditable = false
        self.view.addSubview(resultTextView)
        
        // 设置Label
        for i in 0..<4 {
            setUpLabel(index: i)
        }
        
        // 配置输入框
        setUpTextField()
        
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
    
    // 配置label
    private func setUpLabel(index: NSInteger) {
        
        let label = UILabel(frame: CGRect(x: 60, y: 100 + 50 * index, width: 110, height: 30))
        
        switch index {
        case 0: label.text = "总价(单位:万):"
        case 1: label.text = "利率:"
        case 2: label.text = "分期(单位:年):"
        case 3: label.text = "首付(单位:成):"
        default:
            break
        }
        
        label.backgroundColor = UIColor.green
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        
    }
    
    
    
    
    // 开始核算贷款
    @objc private func touchContAction() {
        
        if totalPrice.text == "" {
            sumLabel.text = "总价不能为空"
            return
        }
        if interestRate.text == "" {
            sumLabel.text = "利率不能为空"
            return
        }
        if instalment.text == "" {
            sumLabel.text = "期数不能为空"
            return
        }
        if downPayment.text == "" {
            sumLabel.text = "首付成数不能为空"
            return
        }
        
        // 总价
        let totalPriceDouble = Double(totalPrice.text!)! * 10000
        
        // 首付
        let downPaymentDouble = totalPriceDouble * (Double(downPayment.text!)! / 10)
        
        // 需贷款金额
        let lending = totalPriceDouble - downPaymentDouble
        
        // 每月利率
        let interestRateDouble = Double(interestRate.text!)! / 12 / 100
        
        // 总月数
        let month = Double(instalment.text!)! * 12
        
        
        // 计算每月还款金额
        /*
         * 计算公式  每月还款 = （贷款总额 * 月利率 * （1 + 月利率）^ 总月数）/ （（1 + 月利率）^ 总月数 - 1）
         */
        let everyMonthMoney = (lending * interestRateDouble * pow((1 + interestRateDouble), month)) / (pow((1 + interestRateDouble), month) - 1)
        
        // 计算总还款金额
        let sumMoney = everyMonthMoney * month + downPaymentDouble;
        
        sumLabel.text = "总花费(单位:元):\(sumMoney)\n"
        
        resultTextView.text = "每月需还款金额(单位:元):\(everyMonthMoney)\n";
        
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
