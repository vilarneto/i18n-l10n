//
//  DetailsViewController.swift
//  i18n-l10n
//
//  Created by Vilar da Camara Neto on 12/09/18.
//  Copyright © 2018 Vilar da Camara Neto. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


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

        // MARK: 01 lastLoginLabel
        if let lastLoginDate = getLastLoginDate() {
            lastLoginLabel.text = String(format: lastLoginLabel.text!, lastLoginDate as NSDate)
        } else {
            lastLoginLabel.text = "Welcome, this is your first login!"
        }

        // MARK: 02 downloadCountLabel
        downloadCountLabel.text = String(format: downloadCountLabel.text!, getBytesDownloaded())

        // MARK: 03 distanceLabel
        distanceLabel.text = String(format: distanceLabel.text!, getDistanceTravelled())

        // MARK: 04 attendanceLabel
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

        // MARK: 05 Images
        wrongWayImage.image = UIImage(named: "wrongway-usa")
        noParkingImage.image = UIImage(named: "noparking-usa")
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

    func getLastLoginDate() -> Date? {
        let currentCase = LastLogin(rawValue: DetailsViewController.lastLoginRawValue)!
        let today = Date()

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
