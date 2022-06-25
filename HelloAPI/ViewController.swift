//
//  ViewController.swift
//  HelloAPI
//
//  Created by 黃柏瀚 on 2022/6/25.
//

import UIKit
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var headIMGView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        
        loadingIndicator.hidesWhenStopped = true
        
        //設定 headIMGView 的數值
        headIMGView.clipsToBounds = true
        headIMGView.layer.cornerRadius = headIMGView.frame.height / 2 //圓型 = 高度 / 2
        headIMGView.layer.borderWidth = 1 //邊線粗度
        headIMGView.layer.borderColor = UIColor.gray.cgColor //邊線顏色
        
        //設定 shadowView 的數值
        shadowView.clipsToBounds = false
        shadowView.backgroundColor = UIColor.clear
        shadowView.layer.shadowRadius = shadowView.frame.height / 2
        shadowView.layer.shadowOpacity = 0.6  //陰影不透明度
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 10, height: 10)  //陰影的向外偏移
        
        
    }
 
    func updateData() {
        
        //先清空
        self.nameLabel.text = ""
        self.emailLabel.text = ""
        self.adressLabel.text = ""
        self.phoneLabel.text = ""
        
        loadingIndicator.startAnimating()
        APIModel.share.queryRandomUserAlamofire { response, error in
            if let data = response as? Data{
                let json = JSON(data)
                //print(json)
                
                let name = json["results"][0]["name"]["first"].stringValue + " "
                    + json["results"][0]["name"]["last"].stringValue + " "
                let pic = json["results"][0]["picture"]["large"].stringValue
                let email = json["results"][0]["email"].stringValue + " "
                let adress = json["results"][0]["location"]["street"]["number"].stringValue + " "
                            + json["results"][0]["location"]["street"]["name"].stringValue + " "
                            + json["results"][0]["location"]["city"].stringValue + " "
                            + json["results"][0]["location"]["state"].stringValue + " "
                            + json["results"][0]["location"]["country"].stringValue + " "
                let phone = json["results"][0]["phone"].stringValue + " "
                
                //self.headIMGView.sd_setImage(with: URL(string: pic), completed: nil)
                self.headIMGView.sd_setImage(with: URL(string: pic), completed: { imageView, error, type, url in
                    
                    DispatchQueue.main.async {
                        self.loadingIndicator.stopAnimating()
                    }
                })
                
                DispatchQueue.main.async {
                    self.nameLabel.text = name
                    self.emailLabel.text = email
                    self.adressLabel.text = adress
                    self.phoneLabel.text = phone
                }
            }
        }
    }
    
    @IBAction func updateButtonClick(_ sender: UIButton) {
        updateData()
    }
    
}
