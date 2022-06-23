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
                todoLabel.text = todo.message
            }
        }
    }

    // MARK: Init

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        todo = nil
    }

    // MARK: Methods
}
