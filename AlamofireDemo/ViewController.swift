//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by xiaoyi li on 16/12/30.
//  Copyright © 2016年 xiaoyi li. All rights reserved.
//

import UIKit
/* 如果引用不了下面这句就 build一下 */
import Alamofire

class ViewController: UIViewController {
    
     let BaiduURL = "http://apis.haoservice.com/lifeservice/cook/query?"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* 基础的请求 及JSON数据解析 */
        Alamofire.request("https://api.500px.com/v1/photos").responseJSON { (DataResponse) in
            print(DataResponse.data)
            if let Json = DataResponse.result.value{
                print("Json:\(Json) ")
                // NSData->NSDictonary
                let dic = try? JSONSerialization.jsonObject(with: DataResponse.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
                let status = dic? ["status"]
                print("status is \(status)")
            }
        }
        
        self.getData()
        self.postData()
    }
    
    func getData(){
        let parameters: Dictionary = ["key" : "93c921ea8b0348af8e8e7a6a273c41bd"]
        Alamofire.request("http://apis.haoservice.com/weather/city", method:.get, parameters:parameters).responseJSON { (response) in
            switch response.result {
            case .success:
                print("SUCCESS")
            case .failure:
                print("ERROR")
            }
        }
    }
    
    func postData() {
        // POST
        let parameters: Dictionary = ["key" : "93c921ea8b0348af8e8e7a6a273c41bd"]
        Alamofire.request("http://apis.haoservice.com/weather/city", method: .post,  parameters:parameters) .responseJSON {response  in
            print("result==\(response.result)")
            
            if let jsonValue = response.result.value {
                /*
                 error_code = 0
                 reason = ""
                 result = 数组套字典的城市列表
                 */
                print("code: \(jsonValue)")
            }
        }
    }
}

