//
//  ViewController.swift
//  HealthKitDemo
//
//  Created by 陈磊 on 16/6/29.
//  Copyright © 2016年 SS. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {

    let healthStore = HKHealthStore()//实例对象
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //授权按钮
        let authorizeBtn = UIButton(type: UIButtonType.RoundedRect)
        authorizeBtn.frame = CGRectMake(0, 0, 100, 40)
        authorizeBtn.center = CGPointMake(self.view.center.x, self.view.center.y)
        authorizeBtn.backgroundColor = UIColor.cyanColor()
        authorizeBtn.setTitle("授权", forState: UIControlState.Normal)
        authorizeBtn.addTarget(self, action: Selector("authorizeBtnClick"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(authorizeBtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: 授权按钮点击事件
    func authorizeBtnClick() {
        //判断当前设备是否支持HeathKit
        if HKHealthStore.isHealthDataAvailable() {
            //读取的数据
            let healthKitTypesToRead = NSSet(array:[
                HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)!,//步数
                HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning)!,//步行+跑步距离
                HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!,//体重
                HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)!,//身高
                ])
            
            //请求
            healthStore.requestAuthorizationToShareTypes(nil, readTypes: healthKitTypesToRead as? Set<HKObjectType>, completion: { (result, error) -> Void in
                print(result, error)
            })
        }
    }


}

