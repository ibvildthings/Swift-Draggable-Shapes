//
//  ViewController.swift
//  Peak App
//
//  Created by Pritesh Desai on 5/29/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var canvasView: UIView!

    // MARK: Properties
    // Used to undo actions
    var historyView: UIView?
    
    // Used to keep count of shapes
    var shapeCount: [Shape : Int] = [:]
    
    
    
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
        
        // Save move to the history before making any changes
        historyView = canvasView.copyView()
        
        // Create an object
        let object = myShape(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        // Randomize the point where the shapes are generated
        let randomX = CGFloat(arc4random_uniform(150))
        let randomY = CGFloat(arc4random_uniform(200))
        
        object.center = CGPoint(x: self.view.frame.width / 2 + randomX, y: 300 + randomY)
        
        object.text = shape.rawValue

        // Create and attach a pan gesture
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        panRecognizer.delegate = self
        object.addGestureRecognizer(panRecognizer)
        
        // Add the object to the view and increment the count
        canvasView.addSubview(object)
        incrementCount(for: shape)
        
    }
    
    // Count incrementer
    func incrementCount(for shape: Shape) {
        // Increment counter
        if let count = shapeCount[shape] {
            shapeCount[shape] = count + 1
        }
        else {
            shapeCount[shape] = 1
        }
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Displaying stats.")

        if segue.destination is StatsTableViewController {
            let vc = segue.destination as? StatsTableViewController
            // Pass the shape counts to the next viewcontroller
            vc?.shapeCount = self.shapeCount
        }
    }

    
    
}




