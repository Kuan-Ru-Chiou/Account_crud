//
//  DetailTableViewController.swift
//  記帳
//
//  Created by 邱冠儒 on 2019/7/25.

//

import UIKit

//Delegation protocal for pass data
protocol DetailTableViewControllerDelegate {
    func update(record: Record)
}




class DetailTableViewController: UITableViewController {
    
    
    @IBOutlet weak var typeSegment: UISegmentedControl!
    
    @IBOutlet weak var titleTextField: UITextField!
    

    @IBOutlet weak var costTextField: UITextField!
    
    //delegte property
    var delegate: DetailTableViewControllerDelegate?
    
    //初始化物件
    var record: Record?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let record = record {
            titleTextField.text = record.title
            costTextField.text = record.cost
            typeSegment.selectedSegmentIndex = record.type
        }
        
    }

    
    
    
    
    
    @IBAction func savebuttonpressed(_ sender: Any) {
        //收起user鍵盤
        self.view.endEditing(true)
        
        //檢查use所有欄位 input
        if titleTextField.text?.isEmpty == false, costTextField.text?.isEmpty == false,
            let title = titleTextField.text, let cost = costTextField.text
        {
            record = Record(title: title, cost: cost, type: typeSegment.selectedSegmentIndex)
            delegate?.update(record: record!)
            //利用navigation 內建回到前一頁
            navigationController?.popViewController(animated: true)
        } else {
            //使用者輸入不完整 警告
            let alertController = UIAlertController(title: "Oops", message: "有資料還沒輸入哦", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
        
    


}
