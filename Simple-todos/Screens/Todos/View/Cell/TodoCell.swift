//
//  TodoCell.swift
//  Simple-todos
//
//  Created by 7Peaks on 23/6/2565 BE.
//

import UIKit

class TodoCell: UITableViewCell {
    // MARK: Class Property

    static let identifier = "TodoCell"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    // MARK: Outlets

    @IBOutlet private var todoLabel: UILabel!

    // MARK: Property

    var todo: Todo? {
        didSet {
            if let todo = todo {
                todoLabel.attributedText = getMessageAttributeString(todo.message, todo.complete)
            }
        }
    }

    // MARK: Init

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        todo = nil
    }

    // MARK: Methods

    func getMessageAttributeString(_ text: String, _ complete: Bool) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: text)
        if complete {
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        }
//        else {
//            attributeString.addAttribute(NSAttributedString.Key.sty, value: 2, range: NSRange(location: 0, length: attributeString.length))
//        }

        return attributeString
    }
}
