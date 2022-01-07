import UIKit

// enum作って、configureする。configureどこで使ってるんや？
// それと
class ReminderDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let reminderDetailCellIdentifier = "ReminderDetailCell"
    
    @IBOutlet weak var detailTableView: UITableView! {
        didSet {
            
            detailTableView.dataSource = self
            detailTableView.delegate = self
        }
    }
    
    
    
    
    enum ReminderRow: Int, CaseIterable {
        case title
        case date
        case time
        case notes
        
        // 勝手にいい感じに返してくれる
        func displayText(for reminder: Reminder?) -> String? {
            switch self {
            case .title:
                return reminder?.title
            case .date:
                return reminder?.dueDate.description
            case .time:
                return reminder?.dueDate.description
            case .notes:
                return reminder?.notes
            }
        }
        
        var cellImage: UIImage? {
            switch self {
            case .title:
                return nil
            case .date:
                return UIImage(systemName: "calendar.circle")
            case .time:
                return UIImage(systemName: "clock")
            case .notes:
                return UIImage(systemName: "square.and.pencil")
            }
        }
    }
    
    var reminder: Reminder?
    
    func configure(with reminder: Reminder) {
        self.reminder = reminder
    }
}

// TableViewの設定
extension ReminderDetailViewController {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReminderRow.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.reminderDetailCellIdentifier, for: indexPath)
        let row = ReminderRow(rawValue: indexPath.row)
        cell.textLabel?.text = row?.displayText(for: reminder)
        cell.imageView?.image = row?.cellImage
        return cell
    }
}
