//
//  FirstViewController.swift
//  CanTool
//
//  Created by Spencer Paschal on 8/11/15.
//  Copyright (c) 2015 Spencer Paschal. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btnA: UIButton!
    @IBOutlet weak var btnB: UIButton!
    @IBOutlet weak var btnC: UIButton!
    @IBOutlet weak var btnD: UIButton!
    @IBOutlet weak var btnE: UIButton!
    @IBOutlet weak var btnF: UIButton!
    
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var displayLabel: UITextField!
    
    enum Mode {
        case Dec, Hex
    }
    
    var mode:Mode = .Dec
    
    var displayText:String = "0"
    var displayValue:UInt32 = 0
    
    var cleared:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cleared = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func convertString (str:String) -> UInt32? {
        let val = Int(str)
        var retval:UInt32 = 0
        if val != nil {
            if (val > 0) && (val < Int(UInt32.max)) {
                retval = UInt32(val!)
            }
        }
        return retval
    }
    
    @IBAction func segChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            print("Changed to Dec")
            self.mode = .Dec
        } else {
            print("Changed to Hex")
            self.mode = .Hex
        }
        clearAll()
    }

    @IBAction func keyPress (object: AnyObject) {
        
        var keyText:String = ""
        
        if let title = object as? UIButton {

            switch (title) {
            case btn1:
                keyText = "1"
            case btn2:
                keyText = "2"
            case btn3:
                keyText = "3"
            case btn4:
                keyText = "4"
            case btn5:
                keyText = "5"
            case btn6:
                keyText = "6"
            case btn7:
                keyText = "7"
            case btn8:
                keyText = "8"
            case btn9:
                keyText = "9"
            case btn0:
                keyText = "0"
            case btnA:
                if mode == .Hex {
                    keyText = "A"
                }
            case btnB:
                if mode == .Hex {
                    keyText = "B"
                }
            case btnC:
                if mode == .Hex {
                    keyText = "C"
                }
            case btnD:
                if mode == .Hex {
                    keyText = "D"
                }
            case btnE:
                if mode == .Hex {
                    keyText = "E"
                }
            case btnF:
                if mode == .Hex {
                    keyText = "F"
                }
                
            default:
                break
            }
            
            if keyText != "" && !keyText.isEmpty {
                if !cleared {
                    displayText = displayLabel.text!
                    displayText += keyText
                    displayLabel.text = displayText
                } else {
                    if mode == .Hex || keyText != "0" {
                        displayLabel.text = keyText
                        cleared = false
                    }
                }
            }
        }
    }
    
    func clearAll () {
        displayValue = 0
        displayText = ""
        displayLabel.text = ""
        cleared = true
    }

    @IBAction func clearPress(sender: AnyObject) {
        clearAll()
    }
    
    @IBAction func deletePress(sender: AnyObject) {
  
    }
    
    @IBAction func enterPress(sender: AnyObject) {
        let text = displayLabel.text
        displayValue = 0
        
        if !text!.isEmpty {
            
            if mode == .Hex {
                let temp = strtoul(text!, nil, 16)
                if temp < UInt(UInt32.max) {
                    let result:UInt32 = UInt32(strtoul(text!, nil, 16))
                    if result > 0 && result < UInt32.max {
                        displayValue = UInt32(result)
                    }
                }
                
            } else if mode == .Dec {
                if let result = convertString(text!) {
                    displayValue = UInt32(result)
                }
            }
        }
        
        if displayValue > 0 && displayValue < UInt32.max {
            print("\(displayValue)")
        } else {
            clearAll()
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showFrameId" {
            
            let navController = segue.destinationViewController as! UINavigationController
            let destinationViewController = navController.topViewController as! FrameIdResult
            
            if displayValue > 0 && displayValue < UInt32.max {
                destinationViewController.frameId = displayValue
            } else {
                destinationViewController.frameId = 0
            }
        }
    }
    
    @IBAction func unwindToFirstVC (segue:UIStoryboardSegue) {
        
    }
}

