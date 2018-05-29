//
//  ViewController.swift
//  Peak App
//
//  Created by Pritesh Desai on 5/27/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var statsButton: UIButton!
    
    @IBOutlet weak var canvasView: UIView!
    
    
    @IBOutlet weak var squareButton: UIButton!
    @IBOutlet weak var circleButton: UIButton!
    @IBOutlet weak var triangleButton: UIButton!
    
    
    // MARK: Shape Types
    enum Shape: String {
        case square = "☐"
        case circle = " ⃝"
        case triangle = "△"
    }
    
    
    // MARK: Properties
    // Used to undo
    var historyView: UIView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Creating Shapes
    @IBAction func createSquare(_ sender: Any) {
        createShape(ofType: .square)
    }
    
    
    @IBAction func createCircle(_ sender: Any) {
        createShape(ofType: .circle)
    }
    
    
    @IBAction func createTriangle(_ sender: Any) {
        createShape(ofType: .triangle)
    }
    
    // Generic shape creating function
    func createShape(ofType shape: Shape) {
        print("Created a shape of type: " + shape.rawValue)
        
        
        
        // Save move to the history
        historyView = canvasView.copyView()
        
        // Create a textview
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        // Randomize the point where the shapes are generated
        let randomX = CGFloat(arc4random_uniform(150))
        let randomY = CGFloat(arc4random_uniform(200))
        
        label.center = CGPoint(x: self.view.frame.width / 2 + randomX, y: 300 + randomY)
        
        // Set the font, shape, color and size of the object
        label.textAlignment = .center
        label.text = shape.rawValue
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica", size: 80)
        
        // Enable panning
        label.isUserInteractionEnabled = true
        
        // Create and attach a pan gesture
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        panRecognizer.delegate = self
        label.addGestureRecognizer(panRecognizer)
        
        // Add the object to the view
        canvasView.addSubview(label)
        
    }
    
    
    // Pangesture recognizer
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        
        // Save move to history
        if recognizer.state == UIGestureRecognizerState.began {
            historyView = canvasView.copyView()
        }
        
        // Logic to handle dragging
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
    }

    
    
    // MARK: Undo
    @IBAction func undoAction(_ sender: Any) {
        // Proceed if history isn't nil
        guard let historyView = historyView else { return }
        
        // Delete all the child subviews
        for child in canvasView.subviews {
            child.removeFromSuperview()
        }
        
        // Add subviews from history
        for child in historyView.subviews {
            canvasView.addSubview(child)
            
            // Create and attach a pan gesture
            let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
            panRecognizer.delegate = self
            child.addGestureRecognizer(panRecognizer)
        }
        
        // Set historyView to nil to prevent further undos
        self.historyView = nil
    }
    
    // MARK: Navigation
    @IBAction func statsPage(_ sender: Any) {
        print("Displaying stats.")
        
    }

}





//MARK: - UIView Extensions
// Used to create a copy of the view
extension UIView
{
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
}
