//
//  Date+Extension.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 20/07/21.
//

import Foundation

enum FormatType: String {
    case HHMMSS = "HH:mm:SS"
    case HHMM = "HH:mm"
    case hhmma = "HH:mm a"
    case YYYYMMDDTHHmmSS = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case hhmmaEEEMMMdd = "hh:mm a EEE,MMM dd"
    case ddMMMMYYYYmmSS = "dd MMMM yyyy hh:mm a"
    case ddMMMYYYYmmSS = "dd MMM yyyy hh:mm a"
    case ddMMMMYYYY = "dd MMMM yyyy"
    case YYYYMMDD = "yyyy-MM-dd"
    case hhmmaddMMYYYY = "hh:mm a, dd-MM-yyyy"
    case DD_MM_YYYY = "dd-MM-yyyy"
    case YYYYMMDD_HHmmSSz = "yyyy-MM-dd HH:mm:ss"
    case MMDDYYYY = "MM/dd/yyyy"
    case DDMMYYYY = "dd/MM/yyyy"
    case MMDDYY = "MM/dd/yy"
    case DDMMYY = "dd/MM/yy"
    case DDMMMYYYY = "dd MMM, yyyy"
}

extension Date {
    func getFormattedDate() -> String? {
        let date = self
        let dateFormatter = DateFormatter()
        
        if Calendar.current.isDateInTomorrow(date) {
            return "Tomorrow"
        }else if Calendar.current.isDateInYesterday(date) {
            return "Yesterday"
        }else if dateFallsInCurrentWeek(date: date) {
            if Calendar.current.isDateInToday(date) {
                dateFormatter.dateFormat = "hh:mm a"
                return dateFormatter.string(from: date)
            }else {
                dateFormatter.dateFormat = "EEEE"
                return dateFormatter.string(from: date)
            }
        }else {
            dateFormatter.dateFormat = "MMM d, yyyy"
            return dateFormatter.string(from: date)
        }
    }
    func dateFallsInCurrentWeek(date: Date) -> Bool {
        let currentWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: Date())
        let datesWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: date)
        return (currentWeek == datesWeek)
    }
    func convertToDateString(formatType: FormatType) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType.rawValue
        return dateFormatter.string(from: self)
    }
    func convertToLongString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}
