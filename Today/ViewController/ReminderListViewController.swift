//
//  ViewController.swift
//  Today
//
//  Created by shusaku on 2022/01/06.
//

import UIKit

class ReminderListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let cellClassName = "ReminderListCell"
    private let reuseId = "ReminderListCell"
    
    private var reminders: [Reminder] = []
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let cellNib = UINib(nibName: cellClassName, bundle: nil)
            tableView.register(cellNib, forCellReuseIdentifier: reuseId)
//            print(Reminder.testData.count)
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.reminders = Reminder.testData
        self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Reminder.testData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as? ReminderListCell else {
            fatalError("Unable to dequeue ReminderCell")
        }
        let reminder = Reminder.testData[indexPath.row]
        cell.configure(title: reminder.title, dateText: reminder.dueDate.description, isDone: reminder.isComplete) {
            Reminder.testData[indexPath.row].isComplete.toggle()
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        // cellの右側に表示させる矢印みたいなの。IBでUITableViewCell使ってないからコードで設定するしかなかった
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    
    static let showDetailSegueIdentifier = "ShowReminderDetailSegue"
    
    
    // セル押したときにすること
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // segueの設定と、senderでセルの情報を渡してる
        performSegue(withIdentifier: "ShowReminderDetailSegue", sender: tableView.cellForRow(at: indexPath))
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // prepareはsegue遷移前に呼ばれる。
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == Self.showDetailSegueIdentifier,
               // reminderDetailViewのインスタンス？
               let destination = segue.destination as? ReminderDetailViewController,
               let cell = sender as? UITableViewCell,
               let indexPath = tableView.indexPath(for: cell) {
                let reminder = Reminder.testData[indexPath.row]
                destination.configure(with: reminder)
            }
        }

}

