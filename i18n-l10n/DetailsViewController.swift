//
//  DetailsViewController.swift
//  i18n-l10n
//
//  Created by Vilar da Camara Neto on 12/09/18.
//  Copyright © 2018 Vilar da Camara Neto. All rights reserved.
//

import UIKit
import CoreLocation


enum Attendance: Int {
    case willGo = 0
    case willNotGo = 1
    case mayGo = 2
}


enum LastLogin: Int {
    case never = 0
    case today = 1
    case yesterday = 2
    case twoDaysAgo = 3
    case tenDaysAgo = 4
}


class DetailsViewController: UIViewController {
    @IBOutlet var helloLabel: UILabel!
    @IBOutlet var lastLoginLabel: UILabel!
    @IBOutlet var downloadCountLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var attendanceLabel: UILabel!
    @IBOutlet var wrongWayImage: UIImageView!
    @IBOutlet var noParkingImage: UIImageView!

    static var lastAttendanceRawValue: Int = 0
    static var lastLoginRawValue: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        helloLabel.text = String(format: helloLabel.text!, getUserName())

        if let lastLoginDate = getLastLoginDate() {
            //// lastLoginLabel antes de i18n
            lastLoginLabel.text = String(format: lastLoginLabel.text!, lastLoginDate)
            //// lastLoginLabel depois de i18n
//            let calendar = NSCalendar.currentCalendar()
//            let components = calendar.components(.Day, fromDate: lastLoginDate, toDate: NSDate(), options: [])
//
//            let dateFormatter = NSDateFormatter()
//            let numberOfDaysSinceLastLogin = components.day
//
//            let daysAgoPhraseFormat = NSLocalizedString("%d day(s) ago", comment: "format string for a number of days ago")
//            let daysAgoPhrase = String.localizedStringWithFormat(daysAgoPhraseFormat, numberOfDaysSinceLastLogin)
//            
//            dateFormatter.dateStyle = .LongStyle
//            let formatString = NSLocalizedString("Welcome, your last login was at %@ (%@).", comment: "format string for date and number of days since last login")
//            lastLoginLabel.text = String.localizedStringWithFormat(formatString, dateFormatter.stringFromDate(lastLoginDate), daysAgoPhrase)
            //// lastLoginLabel antes de i18n
        } else {
            //// lastLoginLabel antes de i18n
            lastLoginLabel.text = "Welcome, this is your first login!"
            //// lastLoginLabel depois de i18n
            //            lastLoginLabel.text = NSLocalizedString("Welcome, this is your first login!", comment: "Welcome string to the user that logins the first time")
            //// lastLoginLabel fim da i18n
        }

        //// downloadCountLabel antes de i18n
        downloadCountLabel.text = String(format: downloadCountLabel.text!, getBytesDownloaded())
        //// downloadCountLabel depois de i18n
        //        let byteCountFormatter = NSByteCountFormatter()
        //        downloadCountLabel.text = String.localizedStringWithFormat(downloadCountLabel.text!, byteCountFormatter.stringFromByteCount(getBytesDownloaded()))
        //// downloadCountLabel fim da i18n

        //// distanceLabel antes de i18n
        distanceLabel.text = String(format: distanceLabel.text!, getDistanceTravelled())
        //// distanceLabel depois de i18n
        //        let distanceFormatter = MKDistanceFormatter()
        //        distanceLabel.text = String.localizedStringWithFormat(distanceLabel.text!, distanceFormatter.stringFromDistance(getDistanceTravelled()))
        //// distanceLabel fim da i18n

        //// attendanceLabel.text antes de i18n
        var attendanceVerb: String?
        switch getAttendance() {
        case .willGo:
            attendanceVerb = "will"
        case .willNotGo:
            attendanceVerb = "will not"
        case .mayGo:
            attendanceVerb = "may"
        }
        attendanceLabel.text = String(format: attendanceLabel.text!, getBossName(), attendanceVerb!)
        //// attendanceLabel.text depois de i18n
        //        var attendancePhrase: String?
        //        switch getAttendance() {
        //        case .WillGo:
        //            attendancePhrase = NSLocalizedString("you will go", comment: "phrase to say that you will go to the meeting")
        //        case .WillNotGo:
        //            attendancePhrase = NSLocalizedString("you will not go", comment: "phrase to say that you will not go to the meeting")
        //        case .MayGo:
        //            attendancePhrase = NSLocalizedString("you may go", comment: "phrase to say that you may go to the meeting")
        //        }
        //        attendanceLabel.text = String.localizedStringWithFormat(attendanceLabel.text!, getBossName(), attendancePhrase!)
        //// attendanceLabel.text fim da i18n

        //// Imagens antes de i18n
        wrongWayImage.image = UIImage(named: "wrongway-brazil")
        noParkingImage.image = UIImage(named: "noparking-brazil")
        //// Imagens depois de i18n
        //        wrongWayImage.image = UIImage(named: NSLocalizedString("wrongway-brazil", comment: "asset name for \"Wrong Way\" symbol"))
        //        noParkingImage.image = UIImage(named: NSLocalizedString("noparking-brazil", comment: "asset name for \"No Parking\" symbol"))
        //// Imagens fim da i18n
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func getUserName() -> String {
        return "John Doe"
    }

    func getBossName() -> String {
        return "Darth Vader"
    }

    func getBytesDownloaded() -> Int64 {
        return 1234567890
    }

    func getLastLoginDate() -> NSDate? {
        let currentCase = LastLogin(rawValue: DetailsViewController.lastLoginRawValue)!
        let today = NSDate()

        DetailsViewController.lastLoginRawValue = (DetailsViewController.lastLoginRawValue + 1) % 5

        switch currentCase {
        case .never:
            return nil
        case .today:
            return today
        case .yesterday:
            return today.addingTimeInterval(-24 * 60 * 60)
        case .twoDaysAgo:
            return today.addingTimeInterval(-2 * 24 * 60 * 60)
        case .tenDaysAgo:
            return today.addingTimeInterval(-10 * 24 * 60 * 60)
        }
    }

    func getDistanceTravelled() -> CLLocationDistance {
        return 2549.15
    }

    func getAttendance() -> Attendance {
        let ret = DetailsViewController.lastAttendanceRawValue

        DetailsViewController.lastAttendanceRawValue = (DetailsViewController.lastAttendanceRawValue + 1) % 3
        return Attendance(rawValue: ret)!
    }
}
