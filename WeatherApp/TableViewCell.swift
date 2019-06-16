//
//  TableViewCell.swift
//  WeatherApp
//
//  Created by 潤田中 on 2019/06/15.
//  Copyright © 2019 BCC. All rights reserved.
//

import UIKit


class TableViewCell: UITableViewCell {
    //地域名のLabelを紐づけ
    @IBOutlet weak var titleLabel: UILabel!
    //idのLabelを紐づけ
    @IBOutlet weak var idLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    
    }


    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
