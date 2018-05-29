//
//  Utilities.swift
//  Peak App
//
//  Created by Pritesh Desai on 5/29/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

import UIKit

//MARK: - UIView Extensions
// Used to create a copy of the view
extension UIView
{
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
}



//MARK: - Custom UILabel
// Used to create a custom UILabel with the proper fonts and other properties set
class myShape: UILabel {
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.setup()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.setup()
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    
    func setup() {
        // Set the font, alignment, color and size of the object
        self.textAlignment = .center
        self.textColor = UIColor.white
        self.font = UIFont(name: "Helvetica", size: 80)
        
        // Enable panning
        self.isUserInteractionEnabled = true
    }
    
    
}
