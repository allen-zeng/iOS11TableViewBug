import UIKit

class ViewController: UITableViewController, UITextViewDelegate {
    private var section0Count = 0
    private var section1Count = 0

    private var textViewRows: Set<Int> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 52

        tableView.register(UINib(nibName: "Cell52", bundle: nil), forCellReuseIdentifier: "Cell52")
        tableView.register(UINib(nibName: "Cell44", bundle: nil), forCellReuseIdentifier: "Cell44")
        tableView.register(UINib(nibName: "Cell88", bundle: nil), forCellReuseIdentifier: "Cell88")
        tableView.register(UINib(nibName: "TextViewCell", bundle: nil), forCellReuseIdentifier: "text view cell")
        tableView.register(UINib(nibName: "Header", bundle: nil), forHeaderFooterViewReuseIdentifier: "header")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3 + section0Count
        case 1:
            return 1 + section1Count
        default:
            fatalError("no more than 2 sections are expected")
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 1 else {
            return nil
        }

        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case let (0, row) where !textViewRows.contains(row):
            return tableView.dequeueReusableCell(withIdentifier: "Cell52")!
        case (0, _):
            let textViewCell = tableView.dequeueReusableCell(withIdentifier: "text view cell")! as! TextViewCell
            textViewCell.textView.delegate = self
            textViewCell.textView.textContainerInset = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
            textViewCell.textView.textContainer.lineFragmentPadding = 0
            textViewCell.textView.isScrollEnabled = false
            return textViewCell
        case (1, 0):
            return tableView.dequeueReusableCell(withIdentifier: "add to section 2 cell")!
        case (1, _):
            return tableView.dequeueReusableCell(withIdentifier: "Cell88")!
        default:
            fatalError("Unexpected indexPath (\(indexPath.section), \(indexPath.row))")
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard indexPath.section == 1 && indexPath.row == 0 else {
            return
        }

        section1Count += 1
        tableView.insertRows(at: [IndexPath(row: section1Count, section: 1)], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        
        return 52
    }

    @IBAction func addTextView(_ sender: Any) {
        section0Count += 1
        let lastRowIndex: Int = 3 + section0Count - 1
        textViewRows.insert(lastRowIndex)
        tableView.insertRows(at: [IndexPath(row: lastRowIndex, section: 0)], with: .automatic)
    }
    
    @IBAction func addPlainCell(_ sender: Any) {
        section0Count += 1
        let lastRowIndex: Int = 3 + section0Count - 1
        tableView.insertRows(at: [IndexPath(row: lastRowIndex, section: 0)], with: .automatic)
    }

    func textViewDidChange(_ textView: UITextView) {
        let lastScrollOffset = tableView.contentOffset
        tableView.beginUpdates()
        tableView.endUpdates()
        tableView.layer.removeAllAnimations()
        tableView.setContentOffset(lastScrollOffset, animated: false)
    }
}
