//
//  FrameIdResult.swift
//  CanTool
//
//  Created by Spencer Paschal on 8/12/15.
//  Copyright (c) 2015 Spencer Paschal. All rights reserved.
//

import UIKit

class FrameIdResult: UIViewController {
    
    @IBOutlet weak var frameDecLabel: UILabel!
    @IBOutlet weak var frameHexLabel: UILabel!
    @IBOutlet weak var pgnField: UITextField!
    @IBOutlet weak var priorityField: UITextField!
    @IBOutlet weak var reservedBitField: UITextField!
    @IBOutlet weak var dataPageField: UITextField!
    @IBOutlet weak var pdufField: UITextField!
    @IBOutlet weak var pdusField: UITextField!
    @IBOutlet weak var sourceAddressField: UITextField!
    
    var frameId:UInt32 = 0
    var pgn:UInt32 = 0
    var priority:UInt8 = 0
    var reservedBit:UInt8 = 0
    var dataPage:UInt8 = 0
    var pduf:UInt8 = 0
    var pdus:UInt8 = 0
    var sourceAddress:UInt8 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("\(frameId)")
        
        calculateData()
    }
    
    func calculateData () {
        if frameId > 0 && frameId < UInt32.max {
            frameDecLabel.text = String(frameId)
            
            var hexString = String(frameId, radix: 16, uppercase:false)
            hexString = hexString.uppercaseString
            
            frameHexLabel.text = hexString
            
            //frameHexLabel.text = String()
            
            let data:UInt32 = frameId
            
            sourceAddress = UInt8(data & 0x000000FF)
            pdus          = UInt8((data >> 8)  & 0x000000FF)
            pduf          = UInt8((data >> 16) & 0x000000FF)
            dataPage      = UInt8((data >> 24) & 0x00000001)
            reservedBit   = UInt8((data >> 25) & 0x00000001)
            priority      = UInt8((data >> 26) & 0x00000007)
           
            pgn = UInt32(reservedBit) & 0x00000001
            pgn <<= 1
            pgn = UInt32(dataPage) & 0x00000001
            pgn <<= 8
            pgn = pgn + UInt32(pduf) & 0x000000FF
            pgn <<= 8
            
            if pduf > 239 {
                pgn += UInt32(pdus) & 0x000000FF
            }
            
            pgnField.text = String(pgn)
            dataPageField.text = String(dataPage)
            reservedBitField.text = String(reservedBit)
            pdusField.text = String(pdus)
            pdufField.text = String(pduf)
            sourceAddressField.text = String(sourceAddress)
            priorityField.text = String(priority)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelToViewController2(segue:UIStoryboardSegue) {
        print("Cancelling")
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //let destinationController = segue.destinationViewController as! UIViewController
     //   let navController = segue.destinationViewController as! UINavigationController
     //   let destinationViewController = navController.topViewController as! FirstViewController
        print("Unwinding")
    }
}
