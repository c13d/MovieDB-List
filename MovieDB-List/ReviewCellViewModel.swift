//
//  ReviewCellViewModel.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 25/02/23.
//

import Foundation

struct ReviewCellViewModel {
    
    let review: Review
    
    var relativeDate: String{
        // 2019-07-30T08:28:10.884Z
        // yyyy-MM-ddTHH:mm:ss
        let prefixStrDate: String = String(review.created_at.prefix(10))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: prefixStrDate) else { return "" }

        return getRelativeDate(date: date)
    }
    
    var profilePictureText: String{
        let fullName = review.author
        let fullNameExtract = fullName.components(separatedBy: " ")
        
        if fullNameExtract.count == 1 {
            let left =  Array(fullName)[0]
            let right = Array(fullName)[1]
            return "\(left)\(right)"
        }
        
        let left =  Array(fullNameExtract[0])[0]
        let right = Array(fullNameExtract[1])[0]
        return "\(left)\(right)"
    }
    
    init(review: Review) {
        self.review = review
    }
    
    private func getRelativeDate(date: Date) -> String{
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let relativeDate = formatter.localizedString(for: date, relativeTo: Date.now)
        
        return relativeDate == "in 0 seconds" ? "now" : relativeDate
    }
    
    
}

