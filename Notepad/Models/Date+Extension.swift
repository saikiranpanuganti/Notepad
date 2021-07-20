//
//  Date+Extension.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 20/07/21.
//

import Foundation

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
                dateFormatter.dateFormat = "Today h:mm a"
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
}
