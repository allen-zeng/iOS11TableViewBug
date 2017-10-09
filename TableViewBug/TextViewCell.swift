import UIKit

class TextViewCell: UITableViewCell {
    @IBOutlet
    weak var textView: UITextView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
