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
        let image = reminder.isComplete ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
        cell.titleLabel.text = reminder.title
        cell.dateLabel.text = reminder.dueDate.description
        cell.doneButton.setBackgroundImage(image, for: .normal)
        cell.doneButtonAction = {
            Reminder.testData[indexPath.row].isComplete.toggle()
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        // cellの右側に表示させる矢印みたいなの。IBでUITableViewCell使ってないからコードで設定するしかなかった
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    
    // segueの設定 UITableViewCell使ってないから、コードで設定。
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowReminderDetailSegue", sender: tableView.cellForRow(at: indexPath))
    }

}

