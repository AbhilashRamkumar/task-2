//
//  BookingViewTableViewController.swift
//  conference room booking
//
//  Created by Admin on 13/04/19.
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


class BookingRegisterTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var BookingsDetails = [bookingstruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        self.BookingDetails()
        

     
        
        tableView.separatorStyle = .none
        
       
        self.tableView.reloadData()
    
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
                    if let data : [String:Any] = snap.value as? [String:Any] {
                        if let name : String = data["name"] as? String,let date : String = data["date"] as? String, let time1 : String = data["StartTime"] as? String, let time2 : String = data["EndTime"] as? String, let confinRoomNo : String = data["conferenceHall"] as? String{
                           
                            
                            self.BookingsDetails.append(bookingstruct(name: "name", date: "date", StartTime: "StartTime", EndTime: "EndTime", conferenceHall: "conferenceHall"))

                            
                           
                            
                        }
                        
                    }
                    
                }
            }
        
        })
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
       
    }
    
    

}
    
extension BookingRegisterTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookingsDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
