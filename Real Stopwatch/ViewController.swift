//
//  ViewController.swift
//  Real Stopwatch
//
//  Created by Roydon Jeffrey on 6/13/16.
//  Copyright © 2016 Italyte. All rights reserved.
//

import UIKit

//Allows the view controller to be responsible for the table view
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    var lapTime = [Double]()
//    var timer = NSTimer()
    
    //Link all the necessary UI object as outlets and actions
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var lapsTableView: UITableView!
    @IBOutlet var startStopButton: UIButton!
    @IBOutlet var lapResetButton: UIButton!
    
    @IBAction func startStop(sender: AnyObject) {
        
        print("Firing")
        
    }
    
    @IBAction func lapReset(sender: AnyObject) {
        
        print("Working")
        
    }
    
    //Determines how many rows the table view should have
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return 3
        
    }
    
    //Responsible for the content and values within the cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Use Value1 to align "Lap" on the left side of the cell and it value on the right side of the cell
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel?.text = "Lap"
        cell.detailTextLabel?.text = "00:00:00"
        return cell
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

