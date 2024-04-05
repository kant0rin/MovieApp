//
//  String + ext.swift
//  MovieApp
//
//  Created by Илья Канторин on 28.03.2024.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func countIndex(_ char:Character) -> Int{
            var count = 0
            var temp = self
      
            for c in self{
                
                if c == char {
                    
                    return count

                }
                count += 1
             }
            return -1
        }
    
    func convertToTwoDots() -> String {
        let indexeOfFirstDot = countIndex(".")
        guard let indexOfSecondDot = self[self.index(startIndex, offsetBy: indexeOfFirstDot+1)..<endIndex].firstIndex(of: ".") else {return String(self[self.startIndex...self.index(startIndex, offsetBy: indexeOfFirstDot)])}
        
        return String(self[self.startIndex...indexOfSecondDot])
    }
    
    mutating func converToTwoDots() {
        self = self.convertToTwoDots()
    }
}
