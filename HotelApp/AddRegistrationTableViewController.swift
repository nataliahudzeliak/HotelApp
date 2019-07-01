//
//  AddRegistrationTableViewController.swift
//  HotelApp
//
//  Created by MacOS on 3/18/19.
//  Copyright © 2019 MacOS. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeDelegate {
   

    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    
    var isCheckInPickerShown: Bool =  false {
        didSet {
            checkInPicker.isHidden = !isCheckInPickerShown
        }
    }
    var isCheckOutPickerShown: Bool = false {
        didSet {
            checkOutPicker.isHidden = !isCheckOutPickerShown
        }
    }
    
    var roomType: RoomType?
    
    @IBOutlet weak var checkInPicker: UIDatePicker!
    @IBOutlet weak var checkInLabel: UILabel!
    
    
    @IBOutlet weak var checkOutLabel: UILabel!
    
    
    @IBOutlet weak var checkOutPicker: UIDatePicker!
    
    
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var emailGuest: UITextField!
    
  
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateViews()
    }
    
    
    @IBOutlet weak var countOfAdultsLabel: UILabel!
    
    @IBOutlet weak var adultsStepper: UIStepper!
    
    
    @IBOutlet weak var countOfChildrenLabel: UILabel!
    
    @IBOutlet weak var childrenStepper: UIStepper!
    
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
    
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
    }
    
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    func updateRoomType(){
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        } else {
            roomTypeLabel.text = "Not set"
        }
    }
    
    
    
    
    
    func updateNumberOfGuests(){
        countOfAdultsLabel.text = "\(Int(adultsStepper.value))"
        countOfChildrenLabel.text = "\(Int(childrenStepper.value))"
        
    }
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    
    @IBAction func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        
        let firstName = self.firstName.text ?? ""
        let lastName = self.lastName.text ?? ""
        let email = self.emailGuest.text ?? ""
        let checkInDate = self.checkInLabel.text ?? ""
        let checkOutDate = self.checkOutLabel.text ?? ""
        let countOfadults = Int(adultsStepper.value)
        let countOfChildren = Int(childrenStepper.value)
        let hasSwitch = wifiSwitch.isOn
        let room = roomType?.name ?? "Not set"
        print("DONE TAPPED!")
        print("firstName : \(firstName)")
        print("lastName: \(lastName)")
        print("email: \(email)")
        print("check in date: \(checkInDate)")
        print("check out date \(checkOutDate)")
        print("adults: \(countOfadults)")
        print("children: \(countOfChildren)")
        print("wifi : \(hasSwitch)")
        print("roomType: \(room)")
        
        
    }
    var registration: Registration? {
        guard let roomType = roomType else {return nil}
        let firstName = self.firstName.text ?? ""
        let lastName = self.lastName.text ?? ""
        let email = emailGuest.text ?? ""
        let checkInDate = checkInPicker.date
        let checkOutDate = checkOutPicker.date
        let countOfadults = Int(adultsStepper.value)
        let countOfChildren = Int(childrenStepper.value)
        let hasSwitch = wifiSwitch.isOn
        
        return Registration(guestFirstName: firstName, guestLastName: lastName, guestEmail: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfChildren: countOfChildren, numberOfAdult: countOfadults, roomType: roomType, accessToWifi: hasSwitch)
        
        
    }
    
    
    
    
    
    
    
    
    func updateViews(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkOutPicker.minimumDate = checkInPicker.date.addingTimeInterval(86400)
        checkInLabel.text = dateFormatter.string(from: checkInPicker.date)
        
        checkOutLabel.text = dateFormatter.string(from: checkOutPicker.date)
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        updateNumberOfGuests()
        updateRoomType()
        let midNightToday = Calendar.current.startOfDay(for: Date())
        checkInPicker.minimumDate = midNightToday
        checkInPicker.date = midNightToday
        updateViews()
        
        
        
    
        
        
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch(indexPath.section, indexPath.row){
    case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row):
        if isCheckInPickerShown {
            return 216.0
        } else {
            return 0.0
        }
    case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row):
        if isCheckOutPickerShown {
            return 216.0
        } else {
            return 0.0
        }
    default:
        return 44.0
    }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row - 1) :
            if isCheckInPickerShown{
                isCheckInPickerShown = false
            } else if isCheckOutPickerShown {
                isCheckOutPickerShown = false
                isCheckInPickerShown = true
            } else {
                isCheckInPickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row - 1) :
            if isCheckOutPickerShown{
                isCheckOutPickerShown = false
            } else if isCheckInPickerShown {
                isCheckInPickerShown = false
                isCheckOutPickerShown = true
            } else {
                isCheckOutPickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomIdentifier"{
            let destination = segue.destination as? SelectRoomTypeTableViewController
            destination?.delegate = self
            destination?.roomType = roomType
            
            
            
        }
    }
  

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
