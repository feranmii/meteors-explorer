//
//  MeteorTableViewCell.swift
//  meteor-explorer-app
//
//  Created by Feranmi on 19/09/2021.
//

import UIKit

final class MeteorTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: MeteorTableViewCell.identifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        backgroundColor = .background
        textLabel?.textColor = .primaryText
        textLabel?.font = .systemFont(ofSize: 17)
        detailTextLabel?.textColor = .secondaryText
        detailTextLabel?.font = .systemFont(ofSize: 15)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    public func bind(data meteor: MeteorModel) {
        textLabel?.text = meteor.name
        let date = formatDate(dateString: meteor.year ?? "")
        let mass = convertMassToKg(mass: meteor.mass ?? "")
        detailTextLabel?.text = "\(date) · \(mass) kg"
    }
}
