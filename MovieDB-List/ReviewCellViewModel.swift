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
        let date = convertStringToDate(dateString: review.created_at)

        guard let date = date else { return ""}
        return getRelativeDate(date: date)
    }
    
    var profilePictureText: String{
        let fullName = review.author
        
        var text = ""
        var isSpace = true
        
        for name in fullName{
            if text.count == 2 { break }
            if name != " " && isSpace == true{
                isSpace = false
                text.append(name)
            }else if name == " "{
                isSpace = true
            }
        }
        
        return text
    }
    
    init(review: Review) {
        self.review = review
    }
    
    private func getRelativeDate(date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let relativeDate = formatter.localizedString(for: date, relativeTo: Date.now)
        
        return relativeDate
    }
    
    private func convertStringToDate(dateString: String) -> Date? {
        // 2019-07-30T08:28:10.884Z
        // yyyy-MM-ddTHH:mm:ss.SSSZ
        
        let prefixStrDate: String = dateString
        print("Hello \(prefixStrDate)")
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        guard let date = dateFormatter.date(from: prefixStrDate) else { return nil }
        return date
    }
    
    
}

