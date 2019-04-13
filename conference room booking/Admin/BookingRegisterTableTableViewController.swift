//
//  BookingRegisterTableTableViewController.swift
//  conference room booking
//
//  Created by Admin on 12/04/19.
//  Copyright © 2019 Xiphias Softwares. All rights reserved.
//

import UIKit
import Firebase

struct bookingstruct {
    
    let name : String!
    let date : String!
    let StartTime : String!
    let EndTime : String!
    let conferenceHall : String!

   
}


class BookingRegisterTableTableViewController: UITableViewController {
    
   var BookingsDetails = [bookingstruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let databaseref = Database.database().reference()
        
        databaseref.child("BookingDetails").queryOrderedByKey().observe(.childAdded) { snapshot in
            
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                if let data : [String:Any] = snap.value as? [String:Any]{
                 
                    if let time1 : String = data["StartTime"] as? String, let time2 : String = data["EndTime"] as? String, let confinRoomNo : String = data["conferenceHall"] as? String{
                    }
                
                }
            self.BookingRegisterTableViewController.reloadData()
        }
        BookingDetails()
    }
    
    
   
    func BookingDetails(){
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
  
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookingsDetails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "tableListCell")
        
        let nameDetails = cell?.viewWithTag(1) as! UILabel
        nameDetails.text = BookingsDetails[indexPath.row].name
        let dateDetails = cell?.viewWithTag(2) as! UILabel
        dateDetails.text = BookingsDetails[indexPath.row].date
        let startTimeDetails = cell?.viewWithTag(3)  as! UILabel
        startTimeDetails.text = BookingsDetails[indexPath.row].StartTime
        let endTimeDetails = cell?.viewWithTag(4)  as! UILabel
        endTimeDetails.text = BookingsDetails[indexPath.row].EndTime
        let ConferenceHallDetails = cell?.viewWithTag(5)  as! UILabel
        ConferenceHallDetails.text = BookingsDetails[indexPath.row].conferenceHall

        
        
        return cell!
    }
}

