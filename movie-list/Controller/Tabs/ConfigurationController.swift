//
//  ConfigurationController.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 01/12/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import UIKit

final class ConfigurationController: TabBaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyStyle()
    }
    
    private func applyStyle() {
        self.title = R.string.common.settings()
    }
}
