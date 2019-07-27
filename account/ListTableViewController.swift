//
//  ListTableViewController.swift
//  記帳
//
//  Created by 邱冠儒 on 2019/7/25.

//

import UIKit




class ListTableViewController: UITableViewController, DetailTableViewControllerDelegate {
    
    //初始化物件陣列
     var records = [Record]()
    
    
    // delegate method for updating cell data
    func update(record: Record) {
        if let indexPath = tableView.indexPathForSelectedRow {
            // 修改點選cell的資料內容
            records[indexPath.row] = record
            tableView.reloadRows(at: [indexPath], with: .automatic)
            Record.saveToFile(records: records)
        } else {
            // 新增一筆資料到第一列
            records.insert(record, at: 0)
            let newIndexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            Record.saveToFile(records: records)
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    //  read data from document path
        if let records = Record.readFromFile() {
            self.records = records
        }
        
    }


    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return records.count
    }

    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordIDcell", for: indexPath)
        
        // Configure the cell...
        let record = records[indexPath.row]
        cell.textLabel?.text = "\(record.title): \(record.cost)"
        // 0 is for 支出 1 is for 收入
        if record.type == 0 {
            cell.textLabel?.textColor = .red
        } else {
            cell.textLabel?.textColor = .blue
        }
        
        return cell
    }
    
   
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            records.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Record.saveToFile(records: records)
        }
    }
 

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    //prepar 搭配delegation 來傳資料 IOS segue是雙向傳遞的  把要傳的資料準備好 這裡是起點
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let controller = segue.destination as? DetailTableViewController {
            controller.delegate = self
            
            // 若是點選cell，則將cell的資料傳到過去
            if let row = tableView.indexPathForSelectedRow?.row {
                controller.record = records[row]
            }
        }
    }
   

    @IBAction func trashButton(_ sender: Any) {
        
        let controller = UIAlertController(title: "清除資料", message: "確定要清空所有資料", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            Record.deleteFile()
            self.records.removeAll()
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        controller.addAction(okAction)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
        
    }
    
    
    

    
    

