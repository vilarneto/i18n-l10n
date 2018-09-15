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
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: lastLoginDate, to: Date())
            let numberOfDaysSinceLastLogin = components.day!
            let daysAgoPhraseFormat = NSLocalizedString("%d day(s) ago", comment: "format string for a number of days ago")
            let daysAgoPhrase = String.localizedStringWithFormat(daysAgoPhraseFormat, numberOfDaysSinceLastLogin)
            let dateFormatter = DateFormatter()

            dateFormatter.dateStyle = .long
            let formatString = NSLocalizedString("Welcome, your last login was at %@ (%@).", comment: "format string for date and number of days since last login")
            lastLoginLabel.text = String.localizedStringWithFormat(formatString, dateFormatter.string(from: lastLoginDate), daysAgoPhrase)
        } else {
            lastLoginLabel.text = NSLocalizedString("Welcome, this is your first login!", comment: "Welcome string to the user that logins the first time")
        }

        // MARK: 02 downloadCountLabel
        let byteCountFormatter = ByteCountFormatter()

        byteCountFormatter.countStyle = .file
        byteCountFormatter.allowedUnits = .useAll
        byteCountFormatter.isAdaptive = true
        byteCountFormatter.includesUnit = true
        downloadCountLabel.text = String.localizedStringWithFormat(downloadCountLabel.text!, byteCountFormatter.string(fromByteCount: getBytesDownloaded()))

        // MARK: 03 distanceLabel
        let distanceFormatter = MKDistanceFormatter()

        distanceLabel.text = String.localizedStringWithFormat(distanceLabel.text!, distanceFormatter.string(fromDistance: getDistanceTravelled()))


        // MARK: 04 attendanceLabel
        let attendancePhrase: String

        switch getAttendance() {
        case .willGo:
            attendancePhrase = NSLocalizedString("you will go", comment: "phrase to say that you will go to the meeting")
        case .willNotGo:
            attendancePhrase = NSLocalizedString("you will not go", comment: "phrase to say that you will not go to the meeting")
        case .mayGo:
            attendancePhrase = NSLocalizedString("you may go", comment: "phrase to say that you may go to the meeting")
        }
        attendanceLabel.text = String.localizedStringWithFormat(attendanceLabel.text!, getBossName(), attendancePhrase)

        // MARK: 05 Images
        wrongWayImage.image = UIImage(named: NSLocalizedString("wrongway-usa", comment: "asset name for \"Wrong Way\" symbol"))
        noParkingImage.image = UIImage(named: NSLocalizedString("noparking-usa", comment: "asset name for \"No Parking\" symbol"))
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
