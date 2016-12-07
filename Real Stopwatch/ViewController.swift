//
//  ViewController.swift
//  Real Stopwatch
//
//  Created by Roydon Jeffrey on 6/13/16.
//  Copyright © 2016 Italyte. All rights reserved.
//

import UIKit

//Allows the view controller to be responsible for the table view
class ViewController: UIViewController, UITableViewDelegate {
    
    //Create all the necessary variables for each component of the app
    var timer = Timer()
    var minutes: Int = 0
    var seconds: Int = 0
    var fractions: Int = 0
    
    //To keep track of the lap time
    var lapFractions = 0
    var lapSeconds = 0
    var lapMinutes = 0
    var lapString = ""
    
    //To store and keep track of all the laps
    var laps = [String]()
    
    //This will hold the minutes, seconds, and fractions together in one string
    var stopwatchString = ""
    
    //Boolean variables to tell whether the app has started and if any laps has been added
    var startStopwatch: Bool = false
    var addLap: Bool = false
    
    //Link all the necessary UI object as outlets and actions
    @IBOutlet var stopwatchLabel: UILabel!
    @IBOutlet var lapsTableView: UITableView!
    @IBOutlet var startStopButton: UIButton!
    @IBOutlet var lapResetButton: UIButton!
    @IBOutlet var lapTimeLabel: UILabel!
    
    //To determine what the startStop button should do when it is clicked
    @IBAction func startStop(_ sender: AnyObject) {
        
        //Only run this statement if startStopwatch is false
        if !startStopwatch {
            
            //Timer to call the updateStopwatch function every 0.01 second
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.updateStopwatch), userInfo: nil, repeats: true)
            
            //Reset startStopwatch and addLap to true
            startStopwatch = true
            addLap = true
            
            //To reset the images of each button while stopwatch is running
            startStopButton.setImage(UIImage(named: "stopButon.png"), for: UIControlState())
            lapResetButton.setImage(UIImage(named: "lapButton.png"), for: UIControlState())
    
        }else {
            //Stop the timer
            timer.invalidate()
            
            //Reset startStopwatch and addLap to false
            startStopwatch = false
            addLap = false
            
            //To reset the images of each button while stopwatch has been stopped
            startStopButton.setImage(UIImage(named: "startButton.png"), for: UIControlState())
            lapResetButton.setImage(UIImage(named: "resetButton.png"), for: UIControlState())
    
        }
        
    }
    
    @IBAction func lapReset(_ sender: AnyObject) {
    
        if addLap {
            
            //Append the current lapString value whenever lap is clicked
            laps.insert(lapString, at: 0)
            
            //Update the table view to display new data being added
            lapsTableView.reloadData()
            
            //Reset all the values after each lap
            lapFractions = 0
            lapSeconds = 0
            lapMinutes = 0
            
        }else {
            
            //Set addLap to false when reset is clicked
            addLap = false
            
            //Update the image when reset is clicked
            lapResetButton.setImage(UIImage(named: "lapButton.png"), for: UIControlState())
            
            //Reset minutes, seconds, and fractions to 0
            fractions = 0
            seconds = 0
            minutes = 0
            
            //Reset all the lap values when reset is clicked
            lapFractions = 0
            lapSeconds = 0
            lapMinutes = 0
            
            //Reset once reset is clicked
            stopwatchString = "00:00.00"
            lapString = "00:00.00"
            
            //Update the labels according to the stopwatchString and lapString
            stopwatchLabel.text = stopwatchString
            lapTimeLabel.text = lapString
            
            //Empty out the laps array once reset is clicked
            laps.removeAll()
            
            //Update the table view
            lapsTableView.reloadData()
            
        }
        
    }
    
    //Function to be called when startStop button is clicked and startStopwatch is set to false
    func updateStopwatch() {
        
        //Increment fractions and lapFractions by 1
        fractions += 1
        lapFractions += 1
        
        //Check is fractions is equal to 100 to increment seconds by 1 and reset fraction back to 0
        if fractions == 100 {
            
            seconds += 1
            fractions = 0
            
        }
        
        //Check if lapFractions reaches 100 to increment lapSeconds by 1 and reset lapFractions to 0
        if lapFractions == 100 {
            
            lapSeconds += 1
            lapFractions = 0
            
        }
        
        //Check is seconds is equal to 60 to increment minutes by 1 and reset seconds back to 0
        if seconds == 60 {
            
            minutes += 1
            seconds = 0
            
        }
        
        //Check is lapSeconds reaches 60 to increment lapMinutes by 1 and reset lapSeconds back to 0
        if lapSeconds == 60 {
            
            lapMinutes += 1
            lapSeconds = 0
            
        }
        
        //To allow fractions, seconds, and minutes to display a double digit figure at all times
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        //To all lapFractions, lapSeconds, and lapMinutes to a display double digit figure at all times
        let lapFractionsString = lapFractions > 9 ? "\(lapFractions)" : "0\(lapFractions)"
        let lapSecondsString = lapSeconds > 9 ? "\(lapSeconds)" : "0\(lapSeconds)"
        let lapMinutesString = lapMinutes > 9 ? "\(lapMinutes)" : "0\(lapMinutes)"
        
        //Store the values for mniutes, seconds, and fractions in one string as the stopwatch label
        stopwatchString = "\(minutesString):\(secondsString).\(fractionsString)"
        
        //Store the values for lapMinutes, lapSeconds, and lapFractions in one string
        lapString = "\(lapMinutesString):\(lapSecondsString).\(lapFractionsString)"
        
        //Update the stopwatchLabel and lapTimeLabel
        stopwatchLabel.text = stopwatchString
        lapTimeLabel.text = lapString
        
    }
    
    //Determines how many rows the table view should have
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       //The number of rows in the table view must equal the amount of elements in the laps array
       return laps.count
        
    }
    
    //Responsible for the content and values within the cells
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        //Use Value1 to align "Lap" on the left side of the cell and it value on the right side of the cell and set background color of the cells to the background color of the viewController
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")  //Same reuseIdentifier as on Main.storyboard 
        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel?.text = "Lap \(laps.count - indexPath.row)"       //Cell text value
        cell.detailTextLabel?.text = laps[indexPath.row]                 //Cell detail value
        return cell
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //To determine what value the stopwatchLabel and lapTimeLabel take when the app is first loaded
        stopwatchLabel.text = "00:00.00"
        lapTimeLabel.text = "00:00.00"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

