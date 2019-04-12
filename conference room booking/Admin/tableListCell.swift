//
//  tableListCell.swift
//  conference room booking
//
//  Created by Admin on 12/04/19.
//  Copyright © 2019 Xiphias Softwares. All rights reserved.
//

import UIKit
import Firebase 

class tableListCell: UITableViewController {

    
    @IBOutlet weak var nameDetails: UILabel!
    @IBOutlet weak var dateDetails: UILabel!
    @IBOutlet weak var startTimeDetails: UILabel!
    @IBOutlet weak var endTimeDetails: UILabel!
    @IBOutlet weak var ConferenceHallDetails: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }



    

    func fetchBookingDetails(){
        Database.database().reference(withPath: "booking").observeSingleEvent(of: .value, with: { snapshot in
            print(snapshot.children.allObjects.count)
            if snapshot.children.allObjects.count == 0{
                //Saving fo data
                
            }
            else{
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    if let data : [String:Any] = snap.value as? [String:Any]{
                        print(data)
                        
                    }
                }
            }
        })
    }
    

}
