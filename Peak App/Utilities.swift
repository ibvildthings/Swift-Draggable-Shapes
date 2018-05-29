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



//MARK: - UILabel Extensions
// Used to create a custom UILabel with the proper fonts and other properties set
extension UILabel {
    
}
